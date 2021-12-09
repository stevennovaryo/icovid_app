# Readme Me (Kel PBP)

### Nama dan NPM anggota:
- Graciella Regina                   - 2006463282
- Gregorius Bhisma                   - 2006473970
- Hanif Ibrahim Syuaib               - 2006482003
- Izzan Nufail Arvin                 - 2006462922
- Muhammad Kenshin Himura Mahmuddin  - 2006473844
- Najwa Kariza Anjelia               - 2006463452
- Steven Novaryo                     - 2006473951

### Link iCovid App:
- [download iCovid App](https://github.com/stevennovaryo/icovid_app/releases/tag/0.0.1)

### Cerita aplikasi:
Aplikasi kami bernama iCovid. Mulanya berasal dari website kami https://icovid-id.herokuapp.com yang terinspirasi dari website iMaba BEM Fasilkom UI. Harapan dari aplikasi ini adalah dapat menjadi kanal informasi mengenai Covid-19 bagi masyarakat Indonesia. Pengguna juga dapat saling berbagi wawasan melalui forum yang disediakan oleh aplikasi ini. 

### Manfaat aplikasi:
Aplikasi kelompok kami memberikan informasi mengenai Covid-19 dalam bentuk artikel-artikel atau post, menceritakan pengalaman melalui forum, serta update data Covid-19 secara realtime.

### Daftar modul:

```
Authentication    → Registration and login
Home/About        → Halaman utama aplikasi yang menampilkan About iCovid, Cuplikan artikel dan Update Covid-19, serta tampilan testimoni
Utilities         → Form khusus admin ( base model, etc )
Article Post      → Halaman di mana pengguna bisa mencari berita tentang Covid-19
Profile Account   → Profile pemilik akun sendiri
Forum             → Forum tempat pengguna bisa reply satu sama lain mengenai suatu topik
Update Covid-19   → Scraping 
```

### Pembagian

```
Authentication    → Steven Novaryo
Home/About        → Graciella Regina
Utilities         → Hanif Ibrahim Syuaib
Article Post      → Izzan Nufail Arvin
Profile Account   → Najwa Kariza A
Forum             → Gregorius Bhisma
Update Covid-19   → Muhammad Kenshin Himura Mahmuddin
```

### Persona

|  | Pasien Covid-19|Masyarakat Umum |
|--|-------------- | ---------------| 
| Goals | Menemukan referensi bacaan mengenai Covid-19 | Mendapatkan update harian, artikel, dan QnA mengenai Covid-19 di Indonesia|   
| Motivation | Pasien bersemangat untuk lekas sembuh| Masyarakat mengharapkan aplikasi yang mudah digunakan untuk semua kalangan |Masyarakat mengharapkan wadah untuk saling bertukar informasi dengan mudah |

**Admin**     : Bisa mengakses utility untuk melihat log serta menginput berita-berita yang ditampilkan pada Article Post
**Registered User** : Bisa mengakses semua fitur pada aplikasi iCovid, namun tidak bisa mengakses utility dan hanya bertindak sebagai pembaca pada Article Post. User juga bisa me-reply thread pada forum, mengisi feedback pada HomePage
**Unregistered User** : Hanya bisa melihat halaman utama pada aplikasi. Namun tidak bisa mereply thread pada forum dan mengisi formulir yang ada.


### Struktur Projek

Struktur projek secara keseluruhan:

```
lib
|
├── core                   # all universally used components
|   |── routers            # application routes and router
│   ├── widgets            # commonly used widgets or theme
│   ├── services           # network services management
│   └── core.dart          # library (includes all subdirectory of core) 
|
├── modules                # module of each team member 
│   ├── auth                            
│   ├── home
│   ├── utilities
│   ├── article
│   ├── profile
│   ├── forum
│   └── tracker
|
|
├── main.dart               
└── icovid.dart          
```

Setiap module memiliki struktur sebagai berikut:
```
module
|
├── modules                 
│   ├── widget             # all widget
│   └── screen             # all page in the module
│
└── module.dart            
```

### Integrasi Dengan Webservices iCovid

Semua bagian dari aplikasi dalam module yang sebelumnya menggunakan form atau ajax akan menggunakan http request pada flutter.

Mendapatkan data dari server iCovid di heroku akan menggunakan bantuan library `http 0.13.4` atau `dio 4.0.4`. Idealnya semua akan dibuat class yang akan mengatasi pemanggilan Http request ke server. Class tersebut sekaligus mengatasi permasalahan csrf token dan session cookie dari pengguna. 

Untuk mendapatkan csrf token akan diberikan request yerlebih dahulu ke server, kemudian server akan mengembalikan csrf token. Jika csrf token kadarluarsa, maka akan dilakukan request ulang ke server. Jika session kadarluarsa, maka pengguna wajib akan dialihkan untuk login ulang. Baik csrf token dan session cookie akan disimpan ke local storage dari aplikasi.  

API dari semua endpoint disimpan sebagai konstanta untuk meningkatkan kerapian kode. Sehingga akan lebih mudah untuk dilakukan development yang lebih lanjut.