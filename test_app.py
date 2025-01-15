import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_calculator_get(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'<form' in response.data

def test_calculator_add(client):
    response = client.post('/', data={'num1': '2', 'num2': '3', 'operation': 'add'})
    assert response.status_code == 200
    assert b'5.0' in response.data

def test_calculator_subtract(client):
    response = client.post('/', data={'num1': '5', 'num2': '3', 'operation': 'subtract'})
    assert response.status_code == 200
    assert b'2.0' in response.data

def test_calculator_multiply(client):
    response = client.post('/', data={'num1': '2', 'num2': '3', 'operation': 'multiply'})
    assert response.status_code == 200
    assert b'6.0' in response.data

def test_calculator_divide(client):
    response = client.post('/', data={'num1': '6', 'num2': '3', 'operation': 'divide'})
    assert response.status_code == 200
    assert b'2.0' in response.data

def test_calculator_divide_by_zero(client):
    response = client.post('/', data={'num1': '6', 'num2': '0', 'operation': 'divide'})
    assert response.status_code == 200
    assert b'Error: Division by zero' in response.data