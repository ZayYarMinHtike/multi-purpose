<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('user', 'API\UserController');
Route::get('profile', 'API\UserController@profile');
Route::patch('profile', 'API\UserController@updateProfile');
Route::get('findUser', 'API\UserController@search');
Route::get('userscount', 'API\UserController@count');

Route::apiResource('post', 'API\PostController');
Route::get('findPost', 'API\PostController@search');
Route::get('postscount', 'API\PostController@count');

