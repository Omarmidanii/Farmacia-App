<?php

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ClassificationsController;
use App\Http\Controllers\API\MedicinesController;
use App\Http\Controllers\API\OrdersController;
use App\Http\Controllers\API\FavoriteController;
use App\Http\Controllers\ReportController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::controller(AuthController::class)->group(function() { 
    Route::post('register', 'register');
    Route::post('login', 'login');
    Route::post('logout', 'logout')->middleware('auth:sanctum');
});
Route::controller(MedicinesController::class)->middleware('auth:sanctum')->group(function() { 
    Route::post('medicine/create' , 'create');
    Route::get('medicine/index' , 'index');
    Route::get('medicine/showmeds/{id}' , 'showMeds');
    Route::post('medicine/find/{id}' , 'findmed');
    Route::get('medicine/show/{id}' , 'show');
    Route::get('medicine/showall' , 'showall')->name('show_all_medicines');
});

Route::controller(ClassificationsController::class)->prefix('classification')->middleware('auth:sanctum')->group(function(){
    Route::get('/showall' , 'index')->name('Arabic');
    Route::post('/find' , 'find');
});


Route::controller(OrdersController::class)->prefix('order')->middleware('auth:sanctum')->group(function(){
    Route::post('/create' , 'create')->name('Create');
    Route::get('/showall/{lang}' , 'index');
    Route::get('/showonemob/{id}' , 'show')->name('show_one_mob');
    Route::get('/showoneweb/{id}' , 'show')->name('show_one_web');
    Route::post('/set_state' , 'set_state');
    Route::post('/set_payment' , 'set_payment');
});

Route::controller(FavoriteController::class)->prefix('favorite')->middleware('auth:sanctum')->group(function(){
    Route::get('/index' , 'index'); // the user's id
    Route::post('/add' , 'store');
    Route::post('/delete' , 'destroy'); //the med's id
});


Route::controller(ReportController::class)->prefix('report')->middleware('auth:sanctum')->group(function(){
    Route::get('/show30' , 'FirstReport');
    Route::get('/show6' , 'SecondReport');
});