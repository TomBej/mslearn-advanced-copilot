import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_cities_route_spain():
    # Test the /countries/Spain route
    response = client.get("/countries/Spain")
    assert response.status_code == 200
    assert isinstance(response.json(), list)  # Ensure the response is a list
    assert "Seville" in response.json()  # Check if "Seville" exists in the response
    assert len(response.json()) == 1  # Ensure only one city is returned
    assert "Madrid" not in response.json()  # Ensure "Madrid" is not in the response