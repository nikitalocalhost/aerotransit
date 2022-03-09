defmodule Aerotransit.AirportTest do
  use Aerotransit.DataCase

  alias Aerotransit.Airport

  describe "countries" do
    alias Aerotransit.Airport.Country

    import Aerotransit.AirportFixtures

    @invalid_attrs %{name: nil}

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Airport.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Airport.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Country{} = country} = Airport.create_country(valid_attrs)
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Airport.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Country{} = country} = Airport.update_country(country, update_attrs)
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Airport.update_country(country, @invalid_attrs)
      assert country == Airport.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Airport.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Airport.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Airport.change_country(country)
    end
  end

  describe "passengers" do
    alias Aerotransit.Airport.Passenger

    import Aerotransit.AirportFixtures

    @invalid_attrs %{age: nil, full_name: nil, passport: nil, sex: nil}

    test "list_passengers/0 returns all passengers" do
      passenger = passenger_fixture()
      assert Airport.list_passengers() == [passenger]
    end

    test "get_passenger!/1 returns the passenger with given id" do
      passenger = passenger_fixture()
      assert Airport.get_passenger!(passenger.id) == passenger
    end

    test "create_passenger/1 with valid data creates a passenger" do
      valid_attrs = %{age: 42, full_name: "some full_name", passport: "some passport", sex: true}

      assert {:ok, %Passenger{} = passenger} = Airport.create_passenger(valid_attrs)
      assert passenger.age == 42
      assert passenger.full_name == "some full_name"
      assert passenger.passport == "some passport"
      assert passenger.sex == true
    end

    test "create_passenger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Airport.create_passenger(@invalid_attrs)
    end

    test "update_passenger/2 with valid data updates the passenger" do
      passenger = passenger_fixture()

      update_attrs = %{
        age: 43,
        full_name: "some updated full_name",
        passport: "some updated passport",
        sex: false
      }

      assert {:ok, %Passenger{} = passenger} = Airport.update_passenger(passenger, update_attrs)
      assert passenger.age == 43
      assert passenger.full_name == "some updated full_name"
      assert passenger.passport == "some updated passport"
      assert passenger.sex == false
    end

    test "update_passenger/2 with invalid data returns error changeset" do
      passenger = passenger_fixture()
      assert {:error, %Ecto.Changeset{}} = Airport.update_passenger(passenger, @invalid_attrs)
      assert passenger == Airport.get_passenger!(passenger.id)
    end

    test "delete_passenger/1 deletes the passenger" do
      passenger = passenger_fixture()
      assert {:ok, %Passenger{}} = Airport.delete_passenger(passenger)
      assert_raise Ecto.NoResultsError, fn -> Airport.get_passenger!(passenger.id) end
    end

    test "change_passenger/1 returns a passenger changeset" do
      passenger = passenger_fixture()
      assert %Ecto.Changeset{} = Airport.change_passenger(passenger)
    end
  end

  describe "companies" do
    alias Aerotransit.Airport.Company

    import Aerotransit.AirportFixtures

    @invalid_attrs %{government: nil, name: nil, register: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Airport.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Airport.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{government: true, name: "some name", register: "some register"}

      assert {:ok, %Company{} = company} = Airport.create_company(valid_attrs)
      assert company.government == true
      assert company.name == "some name"
      assert company.register == "some register"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Airport.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()

      update_attrs = %{
        government: false,
        name: "some updated name",
        register: "some updated register"
      }

      assert {:ok, %Company{} = company} = Airport.update_company(company, update_attrs)
      assert company.government == false
      assert company.name == "some updated name"
      assert company.register == "some updated register"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Airport.update_company(company, @invalid_attrs)
      assert company == Airport.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Airport.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Airport.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Airport.change_company(company)
    end
  end
end
