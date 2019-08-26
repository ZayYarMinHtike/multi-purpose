@extends('layouts.app')

    @section('content')
    <div class="container">
      <div class="col-md-4 col-sm-6">
      <form action="/search" method="POST" role="search">
          {{ csrf_field() }}
          <div class="input-group">
              <input type="text" class="form-control" name="q"
                  placeholder="Search Posts"> <span class="input-group-btn">
                  <button type="submit" class="btn btn-default">
                  <i class="fas fa-search"></i>
                  </button>
              </span>
          </div>
      </form>
      </div>
      <div class="row align-items-center">
        <div class="col-md-8 mx-auto">
          <h1 class="my-4 text-center"><strong> Myanmar Links </strong></h1>

          @foreach ($posts as $post)
          <div class="card card-widget mb-4">
              <div class="card-header">
                <div class="user-block">
                  <img class="img-circle" src="{!! ($post->user->photo == 'profile.png') ? '/storage/images/dummy/dummy-profile.png' : '/storage/images/profile-uploads/' . $post->user->photo !!}">
                  <span class="username"><a href="#">{{ $post->user->name }}</a></span>
                  <span class="description">Posted - {{ $post->created_at->diffForHumans() }}</span>
                </div>
              </div>
              <!-- /.card-header -->
              <div>
                <div class="mt-3" style="text-align: center"><h2>{{ $post->title }}</h2></div>
                <hr>
                <div class="container d-flex justify-content-center">
                <img class="img-fluid pad mb-3" src="{!! !empty($post->image) ? '/storage/images/post-img/' . $post->image :  '' !!}">
                </div>
             
                <div class="card-text pl-4 pr-4 mb-3">
                <p class="card-text" 
                style="text-indent: 100px;
                        text-align: justify;
                        font-size: 16px;"
                > {{ str_limit($post->body, $limit = 280, $end = '...') }} </p>
                <a href="/posts/{{ $post->id }}" class="btn btn-primary">Read More &rarr;</a>
                </div>
              </div>
              <!-- /.card-body -->
              
              <!-- /.card-footer -->
              <div class="card-footer">
                
              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          @endforeach
          {{ $posts->links() }}
        </div>
      </div>
    </div>
@endsection