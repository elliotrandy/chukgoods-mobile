# chukgoods_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tugas 7

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree adalah struktur hierarki dari widget-widget yang membentuk UI aplikasi Flutter. Setiap widget dapat memiliki satu atau lebih child widget, dan hubungan parent-child bekerja dengan cara parent widget mengatur layout dan perilaku child-nya. Parent widget bertanggung jawab atas positioning, sizing, dan rendering child widget. Misalnya, Scaffold adalah parent yang memiliki AppBar dan body sebagai child.

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

- MaterialApp: Widget root yang menyediakan tema dan navigasi untuk aplikasi Material Design.
- Scaffold: Struktur dasar halaman dengan AppBar, body, dan floating action button.
- AppBar: Bar atas halaman yang menampilkan judul.
- Padding: Menambahkan padding di sekitar child widget.
- Column: Mengatur child widget secara vertikal.
- Row: Mengatur child widget secara horizontal.
- Center: Memposisikan child di tengah parent.
- Text: Menampilkan teks.
- Card: Container dengan elevation untuk menampilkan informasi.
- Container: Widget yang dapat dikustomisasi untuk layout.
- GridView.count: Menampilkan child dalam grid dengan jumlah kolom tertentu.
- Material: Widget yang memberikan efek material seperti warna dan border radius.
- InkWell: Membuat area yang dapat diklik dengan efek ripple.
- Icon: Menampilkan ikon.
- SizedBox: Memberikan jarak antar widget.
- ScaffoldMessenger: Menampilkan snackbar.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp adalah widget yang menyediakan konfigurasi untuk aplikasi Material Design, termasuk tema, routing, dan lokalization. Ia sering digunakan sebagai root karena menyediakan semua konfigurasi dasar yang diperlukan untuk aplikasi Flutter, seperti tema warna, font, dan navigasi antar halaman.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

StatelessWidget adalah widget yang tidak memiliki state internal dan tidak berubah selama lifecycle-nya. StatefulWidget memiliki state yang dapat berubah, dan menggunakan State object untuk mengelola perubahan. Pilih StatelessWidget untuk widget statis yang tidak perlu update, dan StatefulWidget untuk widget yang perlu merespons interaksi pengguna atau data yang berubah.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menyediakan informasi tentang lokasi widget dalam widget tree. Ia penting karena digunakan untuk mengakses tema, media query, dan ancestor widget. Di metode build, BuildContext digunakan untuk mendapatkan informasi kontekstual seperti ukuran layar atau tema aplikasi.

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Hot reload memperbarui kode aplikasi tanpa kehilangan state aplikasi, sehingga perubahan UI langsung terlihat. Hot restart me-restart aplikasi sepenuhnya, menghilangkan state dan memuat ulang aplikasi dari awal. Hot reload lebih cepat untuk perubahan UI, sedangkan hot restart diperlukan untuk perubahan struktural seperti main.dart.
