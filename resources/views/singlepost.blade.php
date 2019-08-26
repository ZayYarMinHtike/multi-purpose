@extends('layouts.app')

    @section('content')
    <div class="container">
      <div class="row">
       <div class="col-md-10 mx-auto">
        <div class="d-flex mb-5">
        <img style="max-height: 100px; max-width: 100px;" class="img-circle mt-3 mr-3" src="{!! ($post->user->photo == 'profile.png') ? '/storage/images/dummy/dummy-profile.png' : '/storage/images/profile-uploads/' . $post->user->photo !!}">
        <div>
          <h3 class="mt-4">{{ $post->title }} <span class="lead"> by <a href="#"> {{ $post->user->name }} </a></span> </h3>
          <p>Posted - {{ $post->created_at->diffForHumans() }}</p>
          <a href="/posts">back</a>
        </div>
        </div> 
        
          <div class="container d-flex justify-content-center">
                <img class="img-fluid pad mb-3" src="{!! !empty($post->image) ? '/storage/images/post-img/' . $post->image :  '' !!}">
          </div>
          <br>
          <br>
          <br>
          <br>
          <div>
            <p class="card-text" style=
            "text-indent: 100px;
             text-align: justify;
             font-size: 18px;">
             {{ $post->body }}</p>
          
          </div>
          <br>
          @auth
          <Comments
              :user-photo='@json(auth()->user()->photo)'
              :post-id='@json($post->id)' 
              :user-name='@json(auth()->user()->name)'>
          </Comments>
          @endauth
      
        </div>
      </div>
    </div>
@endsection