# Tracker
___

## О приложении

Image Feed - Приложение, которое тесно работает с Unsplash API.
В приложении есть авторизация с момощью OAuth 2.0.

Суть приложения в том, что пользователь, авторизовавшись, может скроллить ленту фотографий,
добавлять понравившиеся фото в избранное, скачивать их или делиться ими другими.
Каждое фото можно детально осмотреть, выбрав его в ленте.

___

## Описание функционала

При запуске приложения, если пользователь не авторизирован, он поподает на экран с кнопкой для входа.

Экран входа:
<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/ImageFeed/blob/main/ReadMeAssets/AuthScreen.png">
</p>

Нажав на кнопку входа открывается web view, с страницей авторизации Unsplash, где пользователю необходимо войти в свой аккаунт:

<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/ImageFeed/blob/main/ReadMeAssets/%20AuthPage.png">
</p>

#

Если пользователь успешно вошел в свой аккаунт, экран с web view закрывается, и появляется экран с изображениями.
Здесь можно тапнуть на значек сердечка у понравившегося изображения и добавить его в избранное.

<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/ImageFeed/blob/main/ReadMeAssets/Feed.png">
</p>

#

Тапнув на изображенияе пользователь попадает на экран, где может рассмотреть фото детальние и поделиться им с друзьями

<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/ImageFeed/blob/main/ReadMeAssets/%20Zoomed.png">
</p>

#

Нажав на вторую кладку в таб баре пользователь увидит данные своего профиля, и, если он решит войти в другой аккаунт или просто захочет выйти из своего,
он может нажать на кнопку выхода из аккаунта. 

После подтверждения выхода пользователь выйдет из аккаунта и попадет на экран авторизцаии.

<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/ImageFeed/blob/main/ReadMeAssets/%20Exit.png">
</p>

#



