<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Post;

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
}
