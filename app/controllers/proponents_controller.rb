# frozen_string_literal: true

# ProponentsController gerencia as ações relacionadas aos proponentes no sistema.
# Ele permite a criação, atualização, visualização, exclusão e listagem de proponentes,
# além de calcular o valor do INSS com base no salário do proponente.
#
# Métodos como `create` e `update` incluem a criação de um job para o cálculo de
# salário com desconto, e `inss_amount` realiza o cálculo do INSS e retorna o valor
# em formato monetário.
#
# As ações de edição e destruição também são gerenciadas por este controlador,
# permitindo modificações e exclusões seguras de registros de proponentes.
#
class ProponentsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :set_proponent, only: %i[edit update destroy]
  before_action :transform_to_type, only: %i[create update inss_amount]

  def index
    @proponents = Proponent.all.page(params[:page]).per(5)
  end

  def new
    @proponent = Proponent.new
    @proponent.build_address
  end

  def edit; end

  def create
    @proponent = Proponent.new(proponent_params)

    respond_to do |format|
      if @proponent.save
        CalculateDiscountedSalaryJob.perform_later(@proponent.id)
        format.html { redirect_to proponents_path, notice: t('proponents.notices.create') }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @proponent.update(proponent_params)
        CalculateDiscountedSalaryJob.perform_later(@proponent.id)
        format.html { redirect_to proponents_path, notice: t('proponents.notices.update') }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @proponent.destroy!

    respond_to do |format|
      format.html { redirect_to proponents_path, status: :see_other, notice: t('proponents.notices.destroy') }
      format.json { head :no_content }
    end
  end

  def inss_amount
    inss_amount = InssCalculator.calculate(params[:proponent][:salary].to_f)

    render json: { inss_amount: number_to_currency(inss_amount, unit: '') }
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def transform_to_type
    transform_salary if params[:proponent][:salary].present?
    transform_inss if params[:proponent][:inss].present?
  end

  def transform_salary
    params[:proponent][:salary] = params[:proponent][:salary].tr('.', '').tr(',', '.')
  end

  def transform_inss
    params[:proponent][:inss] = params[:proponent][:inss].tr('.', '').tr(',', '.')
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :birthdate, :phone, :salary, :inss, :address_id, address_attributes: %i[
        zip_code street number complement neighborhood city state
      ]
    )
  end
end
