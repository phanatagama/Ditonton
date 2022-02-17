![example workflow](https://github.com/phanatagama/Ditonton/actions/workflows/flutter-ci.yml/badge.svg)
![Ditonton](https://socialify.git.ci/phanatagama/Ditonton/image?description=1&descriptionEditable=Build%20with%20Dart%20Programming%20Language%20%26%20Flutter%20Framework&font=Raleway&forks=1&issues=1&language=1&name=1&pattern=Circuit%20Board&pulls=1&stargazers=1&theme=Dark)
<p align="center">
<img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" />
<img src="https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase" />
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white" />
<img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" />
<img src="https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white" />
  </p>
  <p align="center">
    Ditonton adalah aplikasi yang menampilkan informasi film serta serial tv
    <br />
    <a href="https://github.com/phanatagama/Ditonton/releases/download/v.1.0.0-beta/app-debug.apk">Download App</a>
    ·
    <a href="https://github.com/phanatagama/Ditonton/issues/new">Report Bug</a>
    ·
  <a href="https://github.com/phanatagama/Ditonton/issues/new">Request Features</a>
  </p>

## 💡 Background
Dalam rangka menyelesaikan submission Menjadi Flutter Developer Expert, Project ini dibangun dengan mengikuti clean architecture
dan menyesuaikan kriteria kelulusan kelas Dicoding.

## ♻️ Project Goals
Aplikasi ini dibuat dengan tujuan menyelesaikan submission @dicoding kelas Menjadi Flutter Developer Expert

## 🤯 Challenges we faced
Selama melakukan pengembangan diharuskan melakukan migrasi state management provider menjadi BloC/Cubit dan membuat beberapa testing, memastikan kode yang ditulis mengikuti konvensi yang tersedia dan menerapkan keamanan berupa SSL Pinning.

## 🧐 How we built our project
Ditonton adalah aplikasi mobile yang menggunakan Flutter sebagai framework. Data yang ditampilkan diambil melalui 'api.themovidb.org/3' kemudian menggunakan sqflite sebagai penyimpanan lokal.

## 🛠️ Tech Stack Used
| Dart      | Flutter      |Firebase      | Android Studio |
|------------|-------------|-------------|-------------|
| <img src="https://avatars.githubusercontent.com/u/1609975?s=280&v=4" width="150"> | <img src="https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_500,q_auto:good,w_500/v1/gcs/platform-data-dsc/events/1_ilC2Aqp5sZd1wi0CopD1Hw_zT8WoJh.png" width="150"> | <img src="https://www.gstatic.com/devrel-devsite/prod/v84e6f6a61298bbae5bb110c196e834c7f21fe3fb34e722925433ddb936d280c9/firebase/images/touchicon-180.png" width="150"> | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Android_Studio_Icon_%282014-2019%29.svg/1200px-Android_Studio_Icon_%282014-2019%29.svg.png" width="150"> |

Project ini telah terintegrasi dengan Firebase Analytics dan Firebase Crashlytics
<!-- ### Extra Library -->
<!-- - [GoogleFonts](https://pub.dev/packages/google_fonts) for Material-Design style -->


<!-- ## 🔧 The problems and how we deal with it -->
<!-- Tentu saja keterbatasan waktu adalah sebuah masalah bagi kami. Beberapa perencanaan harus kami tunda/hilangkan untuk mempersingkat waktu seperti pembangunan [REST API](https://github.com/MochArisandiJayanto/Flarax/blob/master/API_Design_Architecture.md) yang harus terhenti. Kami memutuskan untuk melakukan query secara langsung dengan database Firebase menggunakan future dan stream. -->

## 🧑‍🎓 What we learned
Membangun project dengan modular adalah hal baru bagi saya, di beberapa bagian saya perlu menuliskan testing terlebih dahulu seperti teori TDD. Penerapan SSL Pinning pada project flutter hingga integrasi project dengan firebase analytics & crashlytics menjadi pembelajaran yang cukup menyenangkan.

## 🐾 Conventional Commit
‎Dalam proyek ini, saya berusaha untuk mengikuti [konvensi commit](https://www.conventionalcommits.org/en/v1.0.0/) sehingga pesan commit lebih bersih dan lebih mudah dibaca. Saya pikir itu luar biasa dan memudahkan saya secara praktis untuk dapat mundur ke setiap penyebaran commit.

<!-- ## 📘 Resource‎ -->
<!-- ### Image Assets -->
<!-- - [Undraw](http://undraw.co) -->
<!-- - [Unsplash](http://unsplash.com) -->

<!-- ### Related Article -->
<!-- - [Barang Menumpuk Tak Terpakai? Akali Dengan 5 Trik Ini | Orami](https://www.orami.co.id/magazine/barang-menumpuk-tak-terpakai-akali-dengan-5-trik-ini/) -->
<!-- - [Bagaimana cara membuang barang bekas berukuran besar, misal kasur, kulkas, mesin cuci? Kemana perabot/barang bekasmu saat kamu membeli perabot baru? - Quora](https://id.quora.com/Bagaimana-cara-membuang-barang-bekas-berukuran-besar-misal-kasur-kulkas-mesin-cuci-Kemana-perabot-barang-bekasmu-saat-kamu-membeli-perabot-baru) -->
<!-- - [Bagaimana caramu membuang barang-barang yang sudah tidak terpakai lagi (misalnya pakaian bekas yang sudah tidak layak pakai)? - Quora](https://id.quora.com/Bagaimana-caramu-membuang-barang-barang-yang-sudah-tidak-terpakai-lagi-misalnya-pakaian-bekas-yang-sudah-tidak-layak-pakai) -->
<!-- - [Bagaimana cara membuang sampah ukuran besar seperti kasur dan lemari secara legal? - Quora](https://bit.ly/3eoe6rK) -->
<!-- - [Cara Mendapatkan Barang Gratis Dari Internet - Blog Orang IT (helmykediri.com)](https://bit.ly/3FuCeVn) -->
<!-- - [Barang Gratis Bisa Kamu Dapatkan di 6 Situs Ini Lho! (lifepal.co.id)](https://lifepal.co.id/media/doyan-berburu-barang-gratisan-cek-6-situs-nih/) -->

<!-- ## 👁️ Preview/Screenshots -->

<!-- - More Application Design in [Figma](https://www.figma.com/file/eISf5jqPckik2Js0NIm7TX/Flarax-App-Prototype?node-id=0%3A1) -->

<!-- | ![landing-page](https://user-images.githubusercontent.com/48324618/145372808-ae5dc7a8-f310-4643-84ed-b678a8aeeff1.jpg) **Landing Page** | ![login-page](https://user-images.githubusercontent.com/48324618/145372649-d459f07a-ba18-4cd0-aee1-fe91524abce5.jpg) **Login Page** | ![register-pagge](https://user-images.githubusercontent.com/48324618/145372937-6fddfba7-4abd-40fa-aa01-c01d349ad1d8.jpg) **Register Page** | ![usr-profile](https://user-images.githubusercontent.com/48324618/145373431-ebd4e049-9558-4fd7-8e0d-80f0b83b02e3.jpg) **User Profile** | -->
<!-- | :--: | :--: | :--: | :--: | -->
<!-- | ![home-page](https://user-images.githubusercontent.com/48324618/145373302-0a966fd3-e787-41c7-8c18-fc1e9ed79588.jpg) **Home Page** | ![detail-product](https://user-images.githubusercontent.com/48324618/145373659-0c01acd8-f2b8-4f9f-a2b3-320117b61593.jpg) **Detail Product** | ![product-page](https://user-images.githubusercontent.com/48324618/145373555-45e28331-c41d-47f1-96a5-74cd2d6d3728.jpg) **Product Page** | ![edit-product](https://user-images.githubusercontent.com/48324618/145373915-5c340a34-9e18-44a8-b81a-cc63882a313a.jpg) **Add/Edit Product** | -->
<!-- |   -->

<!-- ## License -->
<!-- This project is licensed under the GNU GPLv3. -->

<!-- ## Contributors ✨ -->

<!-- Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)): -->

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- <table> -->
<!--   <tr> -->
<!--     <td align="center"><a href="https://github.com/phanatagama"><img src="https://avatars.githubusercontent.com/u/48324618?s=100?v=4" width="100px;" alt=""/><br /><sub><b>Cahyadi Setia Phanatagama</b></sub></a><br /><a href="https://github.com/MochArisandiJayanto/Flarax/commits?author=phanatagama" title="Code">💻</a> <a href="#infra-phanatagama" title="Infrastructure (Databases, Build-Tools, etc)">🚇</a></td> -->
<!--     <td align="center"><a href="https://github.com/MochArisandiJayanto"><img src="https://avatars.githubusercontent.com/u/30518462?v=4?s=100" width="100px;" alt=""/><br /><sub><b>MOCH. ARISANDI JAYANTO</b></sub></a><br /><a href="https://github.com/MochArisandiJayanto/Flarax/commits?author=MochArisandiJayanto" title="Code">💻</a> <a href="#infra-mocharisandijayanto" title="Infrastructure (Build-Tools, etc)">🚇</a></td> -->
<!--     <td align="center"><a href="https://github.com/mrgvnn"><img src="https://avatars.githubusercontent.com/u/81848181?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Samira Rahma Aziza</b></sub></a><br /><a href="https://github.com/MochArisandiJayanto/Flarax/commits?author=mrgvnn" title="Code">💻</a> <a href="#design-mrgvnn" title="Design">🎨</a></td> -->
<!--   </tr> -->
<!-- </table> -->


<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)
