class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[edit update destroy]
  before_action :transform_to_type, only: %i[create update]

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
        format.html { redirect_to proponents_path, notice: t('proponents.notices.create') }
        format.json { render :index, status: :created }
      else
        flash[:alert] = @proponent.errors.full_messages
        format.html { redirect_to new_proponent_path }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @proponent.update(proponent_params)
        format.html { redirect_to proponents_path, notice: t('proponents.notices.update') }
        format.json { render :index, status: :ok }
      else
        flash[:alert] = @proponent.errors.full_messages
        format.html { redirect_to edit_proponent_path(@proponent.id) }
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

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def transform_to_type
    params[:proponent][:salary] = params[:proponent][:salary] = params[:proponent][:salary].tr('.', '').tr(',', '.')
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :birthdate, :phone, :salary, :address_id, address_attributes: %i[
        zip_code street number complement neighborhood city state
      ]
    )
  end
end
