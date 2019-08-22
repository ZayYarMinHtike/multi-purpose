<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Post;

class PostController extends Controller
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
        return Post::latest()->paginate(10);
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
            'title' => 'required|string|max:255',
            'body' => 'required|string',
            'image' => 'sometimes|mimes:jpeg,png,jpg,gif,svg',
        ]);

        $post = new Post;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $name = str_slug($request->title).'.'.$image->getClientOriginalExtension();
            $destinationPath = storage_path('/app/public/images/post-img');
            $imagePath = $destinationPath . "/" . $name;
            $image->move($destinationPath, $name);
            $post->image = $name;
        }
        
        
        $post->user_id = auth('api')->user()->id;
        $post->title = $request->title;
        $post->body = $request->body;
        $post->save();
        
        return $post;

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
        $post = Post::findOrFail($id);

        $this->validate($request, [
            'title' => 'sometimes|required|string|max:255',
            'body' => 'sometimes|required|string',
            'image' => 'sometimes',
        ]);

            $currentImage = $post->image;
        
            if ($request->image != $currentImage) {

                    //double explode the string factors and reposition from ; to 0 position
                    $name = time().'.' . explode('/', explode(':', substr($request->image, 0, strpos(
                        $request->image, ';')))[1])[1];

                    // Image is image-intervation clause    
                    \Image::make($request->image)->save(storage_path('app/public/images/post-img/').$name);
                    $request->merge(['image' => $name]);

                    $oldImage = storage_path('app/public/images/post-img/').$currentImage;
                    if(file_exists($oldImage)) {
                        @unlink($oldImage);
                    }
            }

            $post->update($request->all());
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $post = Post::findOrFail($id);

        $post->delete();
    }
}
