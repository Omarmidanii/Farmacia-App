<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\FavoriteResource;
use App\Models\API\Medicine;
use App\Models\API\Favorite;
use App\Models\User;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $favs = FavoriteResource::collection(Favorite::all()->where('user_id',$request->user()->id));
        return response()->json([
            'data' => $favs
        ]);
    }

    
    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request)
    {
        $med = Medicine::find($request->medicine_id);
        if(!$med) {
            return response()->json([
                'message' =>'Medicine not found',
            ]);
        }
        $fav = Favorite::create([
            'user_id' => $request->user()->id,
            'medicine_id' => $request->medicine_id
        ]);

        return response()->json([
            'message' =>'Added to favorite successfully',
            'data' => $fav
        ]);
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $med = Favorite::where('user_id', $request->user()->id)->where('medicine_id' ,$request->medicine_id);
        if(!$med){
            return response()->json([
                'message' => 'Medicine is not found'
            ]);
        }
        $med->delete();
        return response()->json([
            'message' => 'Deleted Successfully'
        ]);
    }
}
