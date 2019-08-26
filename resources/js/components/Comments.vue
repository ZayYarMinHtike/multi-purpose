<template>
      <div class="card-footer">
          <form>
            <div class="mb-3">
            <img class="img-fluid img-circle img-md" :src="getprofilePic()" alt="Alt Text">
            <div class="img-push d-flex">
              <textarea type="text" ref="body" @keyup.enter="addComment" class="form-control ml-3" placeholder="Press enter to post comment"></textarea>
              <button type="submit" @click.prevent="addComment" class="btn ml-2 btn-primary">
              Submit
              </button>
            </div>
            </div>
            <div>
              <div class="border p-2" v-for="comment in comments" >
                <img class="img-fluid img-circle img-sm"  :src="comPic()+comment.user.photo" alt="Alt Text">
                <div class="img-push">
                <strong>{{ comment.user.name }} </strong>::<span> {{ comment.created_at | myDate }}</span>
                <br>
                <p style="background: #e0e0e0;">{{ comment.body }}</p>
                </div>
              </div>
            </div>
          </form>
      </div>     
</template>
<script>
    export default {
      props: {
        userPhoto:{
          type: String,
          required:true
        },
        userName: {
          type: String,
          required: true
        },
        postId: {
          type: Number,
          required: true
        }
      },
      data() {
        return {
          comments: []
        };
      },


      methods: {
        getprofilePic() {
            if(this.userPhoto == 'profile.png') {
              return '/storage/images/dummy/dummy-profile.png'
            }else {
              return '/storage/images/profile-uploads/'+this.userPhoto;
            }   
        },

        comPic() {
          return  '/storage/images/profile-uploads/'
        },

        getComments() {
         axios.get("/" + this.postId + "/comments").then(response => {
                this.comments = response.data;
                console.log(this.comments);
         })
          
        },

        pageRefresh() {
          axios.get("/posts/" + this.postId);
        },

        addComment() {
          let body = this.$refs.body.value;
          axios.post("/" + this.postId + "/comments", { body }).then(response => {
            this.comments
            .push({
              user: {name: this.userName},
              user: {photo: this.userPhoto},
              body: this.$refs.body.value
            });
            this.$refs.body.value = "";
          })
          Fire.$emit('hasEvent');
        }
      },


      created() {
        this.getComments();

        Echo.private("comment").listen("CommentSent", e => {
            this.comments
            .push({
              user: {name: e.user.name},
              body: e.comment.body,
            });
        });
        
        Fire.$on('hasEvent', () => {
              this.pageRefresh();
        })
      },
    };
</script>