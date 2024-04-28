class Cartera {
  String titulo;
  int precio;
  String poster;

  Cartera(
      {required this.titulo,
      required this.precio,
      required this.poster,});


static List<Cartera> carteras = [
    Cartera(
      titulo: "Cartera 1",
      precio: 2000,
      poster:
          "https://imgs.search.brave.com/qhB4IaXZWU64zN3Hl_Sni51s3EHtCIhNLGWmqSYPlf4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMtbmEuc3NsLWlt/YWdlcy1hbWF6b24u/Y29tL2ltYWdlcy9J/LzgxclVaQWNOWEpM/LmpwZw",
    ),
    Cartera(
      titulo: "Cartera 2",
      precio: 1500,
      poster:
          "https://imgs.search.brave.com/fVzCK7i4LHvo9mlRk35PWqhVSmA5XE2AJFzEbqYGE2Q/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9yZW56/b2Nvc3RhLnZ0ZXhh/c3NldHMuY29tL2Fy/cXVpdm9zL2lkcy8x/OTk2MjctNTAwLWF1/dG8_dj02Mzg0OTA0/OTUxMTE4MzAwMDAm/d2lkdGg9NTAwJmhl/aWdodD1hdXRvJmFz/cGVjdD10cnVl.jpeg",
    ),
    Cartera(
      titulo: "Cartera 3",
      precio: 3000,
      poster:
          "https://imgs.search.brave.com/KgaC8ViCgtWVYJK7y4m0b9ty2DPvZXLbuMgCEPqTyR0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzE5aHFYSmthTkwu/anBn",
    ),
    Cartera(
      titulo: "Cartera 4",
      precio: 3500,
      poster:
          "https://imgs.search.brave.com/pn7XkEU6tUIUXb9jcO7pWD7YjAMnQ9jjvZD5ySPlbg4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFyVXE3RGR1RUwu/anBn",
    ),
    Cartera(
      titulo: "Cartera 5",
      precio: 4000,
      poster:
          "https://imgs.search.brave.com/HrzcJDfjwqmOuWrZDCtXuUn4JodXO6d0SRydI08FaxI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMuZGFmaXRpLmNs/L3AvdG9wc2hvcC00/Mjc2LTY1ODMwNDEt/MS1jYXRhbG9nLW5l/dy5qcGc",
    ),
  ];
}





