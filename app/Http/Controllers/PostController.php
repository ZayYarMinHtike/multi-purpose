<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Post;
use Illuminate\Support\Facades\Input;

class PostController extends Controller
{

    public function all()
    {
        return view('allposts', [
            'posts' => Post::latest()->paginate(5)
        ]);
    }
    
    public function single(Post $post)
    {
        return view('singlepost', compact('post'));
    }

    public function search() {
        $q = Input::get ( 'q' );
        $posts = Post::where('title','LIKE','%'.$q.'%')
                        ->orWhere('body','LIKE','%'.$q.'%')->latest()->paginate(5);
        if(count($posts) > 0) {
            return view('allposts', [
                'posts' => $posts
            ]);
        }else {
            return view('nopost');
        }
    }
}