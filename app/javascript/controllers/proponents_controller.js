import { Controller } from "@hotwired/stimulus"
export default class extends Controller {}

const zipCodeInput = document.querySelector('[id$=zip_code]');
if (zipCodeInput) {
  applyCepMask(zipCodeInput);
  fetchAddressByCep(zipCodeInput);
}

const salaryInput = document.querySelector('[id$=salary]');
if (salaryInput) {
  applySalaryMask(salaryInput);
  getInssAmount(salaryInput);
}

const birthdateInput = document.querySelector('[id$=birthdate]');
if (birthdateInput) {
  applyDateMask(birthdateInput);
}

const phoneInput = document.querySelector('[id$=phone]');
if (phoneInput) {
  applyPhoneMask(phoneInput);
}

function applyCepMask(input) {
  input.addEventListener('input', function () {
    let value = input.value.replace(/\D/g, '');
    if (value.length > 8) value = value.slice(0, 8);

    let formattedValue = value.length > 5
      ? value.slice(0, 5) + '-' + value.slice(5, 8)
      : value.replace(/^(\d{1,5})$/, '$1');

    input.value = formattedValue;
  });
}

function fetchAddressByCep(zipCodeInput) {
  zipCodeInput.addEventListener('blur', function () {
    const zipCode = zipCodeInput.value.replace(/\D/g, '');
    if (zipCode.length === 8) {
      fetch(`https://viacep.com.br/ws/${zipCode}/json/`)
        .then(response => response.json())
        .then(data => {
          if (!data.erro) {
            document.querySelector('[id$=street]').value = data.logradouro;
            document.querySelector('[id$=neighborhood]').value = data.bairro;
            document.querySelector('[id$=city]').value = data.localidade;
            document.querySelector('[id$=state]').value = data.uf;
          } else {
            alert('CEP não encontrado');
          }
        })
        .catch(error => {
          console.error('Erro ao buscar CEP:', error);
          alert('Erro ao buscar o CEP. Tente novamente mais tarde.');
        });
    }
  });
}

function applySalaryMask(input) {
  input.addEventListener('input', function () {
    let value = input.value.replace(/\D/g, '');
    if (value.length > 10) value = value.slice(0, 10);

    let integerPart = value.slice(0, -2);
    let decimalPart = value.slice(-2);

    integerPart = integerPart.startsWith('0') && integerPart.length > 1
      ? integerPart.slice(1)
      : integerPart;

    let formattedIntegerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
    decimalPart = decimalPart.padStart(2, '0');

    input.value = formattedIntegerPart + ',' + decimalPart;
  });
}

function getInssAmount(input) {
  input.addEventListener('blur', function () {
    if (input.value.length > 0) {
      fetch('/proponents/inss_amount', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({ proponent: { salary: input.value } })
      })
      .then(response => response.json())
      .then(data => {
        if (data.inss_amount) {
          document.querySelector('[id$=inss]').value = data.inss_amount;
        }
      })
      .catch(error => {
        console.error('Erro ao buscar o INSS:', error);
        alert('Erro ao calcular o INSS. Tente novamente mais tarde.');
      });
    }
  });
}


function applyDateMask(input) {
  input.addEventListener('input', function () {
    let value = input.value.replace(/\D/g, '');
    if (value.length > 8) value = value.slice(0, 8);

    let formattedValue = value.length > 4
      ? value.slice(0, 2) + '/' + value.slice(2, 4) + '/' + value.slice(4)
      : value.length > 2
      ? value.slice(0, 2) + '/' + value.slice(2)
      : value;

    input.value = formattedValue;
  });
}

function applyPhoneMask(input) {
  input.addEventListener('input', function () {
    let value = input.value.replace(/\D/g, '');
    if (value.length > 11) value = value.slice(0, 11);

    let formattedValue = '';
    if (value.length > 6 && value.length <= 10) {
      formattedValue = `(${value.slice(0, 2)}) ${value.slice(2, 6)}-${value.slice(6)}`;
    } else if (value.length === 11) {
      formattedValue = `(${value.slice(0, 2)}) ${value.slice(2, 3)}${value.slice(3, 7)}-${value.slice(7)}`;
    } else if (value.length > 2) {
      formattedValue = `(${value.slice(0, 2)}) ${value.slice(2)}`;
    } else if (value.length > 0) {
      formattedValue = `(${value}`;
    }

    input.value = formattedValue;
  });
}
