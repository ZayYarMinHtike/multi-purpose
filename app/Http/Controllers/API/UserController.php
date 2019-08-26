<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Hash;

class UserController extends Controller
{
    public function __construct() {

        $this->middleware('auth:api');
        
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return User::latest()->paginate(5);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        
         $this->validate($request, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
            'type' => 'required'
        ]);

        return User::create([
            'name' => $request['name'],
            'email' => $request['email'],
            'type' => $request['type'],
            'bio' => $request['bio'],
            'photo' => 'profile.png',
            'password' => Hash::make($request['password'])
        ]);
    }

    //custom api controller functions which use custom routes

    public function profile()
    {
        return auth('api')->user();
    }

    public function updateProfile(Request $request)
    {
            $user = auth('api')->user();

            $this->validate($request, [
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users,email,'.$user->id,
                'password' => 'sometimes|required|min:6',
                'type' => 'sometimes|required'
            ]);

            $currentPhoto = $user->photo;
        
            if ($request->photo != $currentPhoto) {

                    //double explode the string factors and reposition from ; to 0 position
                    $name = time().'.' . explode('/', explode(':', substr($request->photo, 0, strpos(
                        $request->photo, ';')))[1])[1];

                    // Image is image-intervation clause    
                    \Image::make($request->photo)->save(storage_path('app/public/images/profile-uploads/').$name);
                    $request->merge(['photo' => $name]);

            }

            if(!empty($request->password)){
                    $request->merge(['password' => Hash::make($request['password'])]);
            }

            $user->update($request->all());
            return ['message' => "Success"];
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);
        
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,'.$user->id,
            'password' => 'sometimes|required|min:6',
            'type' => 'sometimes|required'
        ]);

        if(!empty($request->password)){
            $request->merge(['password' => Hash::make($request['password'])]);
        }

        $user->update($request->all());
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user = User::findOrFail($id);
        
        $user->posts()->delete();
        $user->comments()->delete();
        $user->delete();
    }



    public function search(){

        if ($search = \Request::get('q')) {
            $users = User::where(function($query) use ($search){
                $query->where('name','LIKE',"%$search%")
                        ->orWhere('email','LIKE',"%$search%");
            })->paginate(10);
        }else{
            $users = User::latest()->paginate(5);
        }

        return $users;

    }

    public function count() {
        $users = User::all();

        $UsersCount = [
            'users_count' => $users->count()
        ];

        return $UsersCount;
    }
}
