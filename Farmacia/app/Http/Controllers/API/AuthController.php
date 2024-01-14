<?php

namespace App\Http\Controllers\API;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\UserAuthRequest;

class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function register(UserAuthRequest $request)
    {
         if(!$request->username){
             return response()->json([
                 'message'=>'UserName is Required'
             ]);
        }
        if(!is_numeric($request->Phonenumber)){
            return response()->json([
                'message'=>'Phonenumber must be a numeric value'
            ]);
        }
        $validated = $request->validate([
            'Phonenumber' => 'unique:users',
        ]);
        $user = User::create([
            'username' => $request->username,
            'Phonenumber' => $request->Phonenumber,
            'Password' => Hash::make($request->Password),
        ]);
        return response()->json([
            'message' => 'user created successfully',
            'user' => $user,
            'token'=> $user->createToken('laravel_token')->plainTextToken
        ]);
    }

    public function login(UserAuthRequest $request)
    {
    $user = User::where('Phonenumber', $request->Phonenumber)->first();
    if (! $user || ! Hash::check($request->Password, $user->Password)) {
        throw ValidationException::withMessages([
            'Phonenumber' => ['The provided credentials are incorrect.'],
        ]);
    }
    return response()->json([
        'message' => 'User loged in successfully',
        'user' => $user,
        'token'=> $user->createToken('laravel_token')->plainTextToken
    ]);
    }

    public function logout(Request $request)
    {
        $user = $request->user();
        $user->tokens()->delete();
        return response()->json([
            'message' => ' logged out Successfully',
        ]);
    }

}
