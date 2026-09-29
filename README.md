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
