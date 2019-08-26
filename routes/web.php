<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'PostController@all');

Auth::routes();

Route::get('/posts', 'PostController@all');
Route::get('/posts/{post}', 'PostController@single');

Route::get('/member', 'HomeController@member');
Route::get('/home', 'HomeController@index')->name('home');



Route::get('/{post}/comments', 'CommentController@index');
Route::post('/{post}/comments', 'CommentController@store');

//simple payment gate way with stripe
Route::get('/stripe', 'StripePaymentController@stripe');
Route::post('/stripe', 'StripePaymentController@stripePost')->name('stripe.post');


//serch
Route::any('/search', 'PostController@search');

Route::get('{path}', 'HomeController@index')->where('path', '([A-z\d-\/_.]+)?' );