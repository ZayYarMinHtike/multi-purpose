<template>
    <div class="container">
        <div v-if="!$gate.isAdmin()">
          <Not-found></Not-found>
        </div>
        <div class="row" v-if="$gate.isAdmin()">
            <div class="col-lg-3 col-xs-6  mt-5">
                <!-- small box -->
                <div class="small-box bg-teal">
                    <div class="inner">
                    <i><h4>Users</h4></i>

                    <p>{{ this.userscount }}</p>
                    </div>
                    <div class="icon">
                    <i class="fas fa-users"></i>
                    </div>
                    <a href="/users" class="small-box-footer">  <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
                <!-- ./col -->
            <div class="col-lg-3 col-xs-6  mt-5">
                <!-- small box -->
                <div class="small-box bg-cyan">
                    <div class="inner">
                    <i><h4>Blog</h4></i>

                    <p>{{ this.postscount }}</p>
                    </div>
                    <div class="icon">
                    <i class="fas fa-blog"></i>
                    </div>
                    <a href="/blog" class="small-box-footer">  <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
                <!-- ./col -->    
            <div class="col-lg-3 col-xs-6  mt-5">
                <!-- small box -->
                <div class="small-box bg-orange">
                    <div class="inner">
                    <i><h4>Profile</h4></i>

                    <p>edit profile</p>
                    </div>
                    <div class="icon">
                    <i class="fas fa-user"></i>
                    </div>
                    <a href="/profile" class="small-box-footer">  <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
                <!-- ./col -->      
            <div class="col-lg-3 col-xs-6  mt-5">
                <!-- small box -->
                <div class="small-box bg-pink">
                    <div class="inner">
                    <i><h4>Home</h4></i>

                    <p>view posts</p>
                    </div>
                    <div class="icon">
                    <i class="fas fa-home"></i>
                    </div>
                    <a href="/posts" class="small-box-footer">  <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
                <!-- ./col -->      
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return {
                userscount: [],
                postscount: []
            }
        },

        methods: {
            loadUsersCount() {
                axios.get('api/userscount').then(({ data }) => {this.userscount = data.users_count});
            },

            loadPostsCount() {
                axios.get('api/postscount').then(({ data }) => {this.postscount = data.posts_count});
            }
        },
        created() {
            this.loadUsersCount();
            this.loadPostsCount();
        }
    }
</script>
