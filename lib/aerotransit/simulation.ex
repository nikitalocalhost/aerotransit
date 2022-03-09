defmodule Aerotransit.Simulation do
  @moduledoc false
  alias Aerotransit.{Repo, Knowledge, Flights}

  # TODO: check if object already in db

  def simulate_up do
    Repo.transaction(fn _ ->
      try do
        {:ok, country1} = Knowledge.create_country(%{name: "Российская Федерация"})
        {:ok, country2} = Knowledge.create_country(%{name: "США"})

        {:ok, company1} =
          Knowledge.create_company(%{
            name: "Аэротранзит",
            register: "123123123",
            government: false,
            country_id: country1.id
          })

        {:ok, company2} =
          Knowledge.create_company(%{
            name: "USA",
            register: "13331112",
            government: true,
            country_id: country2.id
          })

        {:ok, airport1} =
          Knowledge.create_airport(%{
            name: "Домодедово",
            owner_id: company1.id,
            country_id: country1.id
          })

        {:ok, airport2} =
          Knowledge.create_airport(%{
            name: "Los Angeles International Airport",
            owner_id: company2.id,
            country_id: country2.id
          })

        {:ok, plane_type1} = Knowledge.create_plane_type(%{name: "Грузовой"})
        {:ok, plane_type2} = Knowledge.create_plane_type(%{name: "Пассажирский"})

        {:ok, plane1} =
          Knowledge.create_plane(%{
            code: "123332",
            type_id: plane_type1.id,
            company_id: company1.id
          })

        {:ok, plane2} =
          Knowledge.create_plane(%{
            code: "1233322",
            type_id: plane_type2.id,
            company_id: company2.id
          })

        {:ok, passenger1} =
          Knowledge.create_passenger(%{
            full_name: "Вася Пупкин",
            passport: "123123123",
            age: 24,
            sex: true,
            country_id: country1.id
          })

        {:ok, passenger2} =
          Knowledge.create_passenger(%{
            full_name: "Bob Mayer",
            passport: "44554422A",
            age: 35,
            sex: true,
            country_id: country2.id
          })

        {:ok, passenger3} =
          Knowledge.create_passenger(%{
            full_name: "Alex Veber",
            passport: "44554622A",
            age: 29,
            sex: true,
            country_id: country2.id
          })

        {:ok, route1} =
          Flights.create_route(%{duration: 10 * 60, from_id: airport1.id, to_id: airport2.id})

        {:ok, route2} =
          Flights.create_route(%{duration: 10 * 60, from_id: airport2.id, to_id: airport1.id})

        {:ok, cargo_type1} = Flights.create_cargo_type(%{name: "Обычный"})
        {:ok, cargo_type2} = Flights.create_cargo_type(%{name: "Хрупкий"})
        {:ok, cargo_type3} = Flights.create_cargo_type(%{name: "Опастный"})

        {:ok, cargo1} =
          Flights.create_cargo(%{type_id: cargo_type1.id, company_id: company1.id, weight: 120})

        {:ok, cargo2} =
          Flights.create_cargo(%{type_id: cargo_type2.id, company_id: company2.id, weight: 100})

        {:ok, flight1} = Flights.create_flight(%{plane_id: plane1.id, route_id: route1.id})
        {:ok, flight2} = Flights.create_flight(%{plane_id: plane2.id, route_id: route2.id})

        {:ok, flight_passenger1} =
          Flights.create_flight_passengers(%{flight_id: flight1.id, passenger_id: passenger1.id})

        {:ok, flight_passenger2} =
          Flights.create_flight_passengers(%{flight_id: flight2.id, passenger_id: passenger2.id})

        {:ok, flight_passenger3} =
          Flights.create_flight_passengers(%{flight_id: flight2.id, passenger_id: passenger3.id})

        {:ok, flight_cargo1} =
          Flights.create_flight_cargo(%{flight_id: flight1.id, cargo_id: cargo1.id})

        {:ok, flight_cargo2} =
          Flights.create_flight_cargo(%{flight_id: flight2.id, cargo_id: cargo2.id})

        true
      catch
        _ ->
          Repo.rollback(:error)
          false
      end
    end)
  end

  def simulate_down do
    Repo.transaction(fn _ ->
      try do
        Aerotransit.Repo.delete_all(Flights.FlightCargo)
        Aerotransit.Repo.delete_all(Flights.FlightPassengers)
        Aerotransit.Repo.delete_all(Flights.Flight)
        Aerotransit.Repo.delete_all(Flights.Cargo)
        Aerotransit.Repo.delete_all(Flights.CargoType)
        Aerotransit.Repo.delete_all(Flights.Route)
        Aerotransit.Repo.delete_all(Knowledge.Passenger)
        Aerotransit.Repo.delete_all(Knowledge.Plane)
        Aerotransit.Repo.delete_all(Knowledge.PlaneType)
        Aerotransit.Repo.delete_all(Knowledge.Airport)
        Aerotransit.Repo.delete_all(Knowledge.Company)
        Aerotransit.Repo.delete_all(Knowledge.Country)
        true
      catch
        _ ->
          Repo.rollback(:error)
          false
      end
    end)
  end
end
