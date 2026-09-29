# bookoteka server

Samodzielnie hostowana (Self-hosted) wersja aplikacji **bookoteka** służąca do śledzenia przeczytanych książek oraz generowania raportów miesięcznych i rocznych.

Projekt został stworzony w oparciu o **Ruby on Rails** oraz nowoczesne podejście do interfejsu (Tailwind CSS i Stimulus).

---

## 🚀 Główne funkcjonalności

* **Zarządzanie biblioteczką**: Śledzenie przeczytanych książek, postępów w czytaniu i ocen.
* **Raporty PDF**: Automatyczne generowanie podsumowań w formacie PDF.
* **Lekka i niezależna**: W pełni kontenerowa aplikacja gotowa do uruchomienia na dowolnym serwerze (np. w środowisku domowym typu homelab).

---

## 🛠️ Wymagania wstępne

Zanim przystąpisz do uruchomienia, upewnij się, że na swoim serwerze/komputerze posiadasz zainstalowane:
* **Docker**
* **Docker Compose**

---

## 📦 Szybki start (Instalacja)

Najprostszym sposobem na uruchomienie serwera jest skorzystanie z gotowego obrazu publikowanego w publicznym rejestrze GitHub Container Registry (GHCR) przy użyciu pliku konfiguracyjnego `docker-compose.yml`, który znajdziesz w folderze compose/ repozytorium.

1. Pobierz plik konfiguracyjny `compose/docker-compose.yml` do wybranego katalogu na swoim serwerze.
2. W pliku konfiguracyjnym uzupełnij wymagane zmienne środowiskowe, w tym swój unikalny klucz szyfrujący `RAILS_MASTER_KEY`.
3. W terminalu, w katalogu z plikiem konfiguracyjnym, wykonaj polecenie uruchomienia kontenera w tle:
   ```bash
   docker compose up -d
   ```
4. Aplikacja pobierze najnowszy publiczny obraz z rejestru organizacji i uruchomi się na wskazanym porcie.

---

## 🔒 Bezpieczeństwo i trwałość danych (Wolumeny)

Aplikacja wykorzystuje mechanizm nazwanego wolumenu Dockera przypisanego do katalogu /rails/storage.

* Dzięki temu wszystkie dane (baza danych SQLite oraz wygenerowane raporty) są w pełni bezpieczne i niezależne od samego kontenera.
* Aktualizacja aplikacji do nowszej wersji za pomocą ponownego pobrania obrazu i restartu kontenera nie powoduje utraty zgromadzonych danych.

---

## ⚙️ Konfiguracja środowiskowa

W pliku `compose/docker-compose.yml` możesz dostosować parametry uruchomieniowe:
* **Porty**: Możesz zmienić port zewnętrzny mapowany na port wewnętrzny aplikacji (3000)
* **Zmienne środowiskowe**:
  - `RAILS_ENV=production` – tryb produkcyjny aplikacji (jednak nie zalecane jest zmienianie tej opcji)
  - `RAILS_MASTER_KEY` – Twój klucz master key niezbędny do uruchomienia instancji Rails.
