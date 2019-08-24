<template>
    <div class="container">
      <div class="row">
        <div v-if="!$gate.isAdminOrMember()">
              <Not-found></Not-found>
        </div>
        <div class="col-md-12 mt-5" v-if="$gate.isAdminOrMember()">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Post List</h3>

                <div class="card-tools">
                  <button class="btn btn-success" @click="createModal"> Add New
                    <i class="fas fa-id-card fa-fw"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Title</th>
                      <th>Posted At</th>
                      <th>Edit/Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="post in posts.data" :key = "post.id">
                      <td>{{post.id}}</td>
                      <td>{{post.title}}</td>
                      <td>{{post.created_at | myDate }}</td>
                      <td>
                          <a href="#" @click="updateModal(post)">
                              <i class="fa fa-edit blue fa-fw"></i>
                          </a>
                          /
                          <a href="#" @click="deletePost(post.id)">
                              <i class="fa fa-trash red fa-fw"></i>
                          </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                  <pagination :data="posts" @pagination-change-page="getResults">
                    <span slot="prev-nav">&lt; Previous</span>
	                  <span slot="next-nav">Next &gt;</span>
                  </pagination>
              </div>
            </div>
            <!-- /.card -->
          </div>
      </div>
      <!-- / .the res table end here -->
        <!-- Modal -->
        <div class="modal fade" id="AddnewModal" tabindex="-1" role="dialog" aria-labelledby="AddnewModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" v-show="!editmode" id="AddnewModalLabel">Add New Post</h5>
                <h5 class="modal-title" v-show="editmode" id="AddnewModalLabel">Update Post Info:</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form v-show="!editmode" @submit.prevent="createPost()">
                <div class="modal-body">
                    <div class="form-group">
                      <input type="title" ref="title" class="form-control" id="title" placeholder="Enter title" required>
                    </div>

                    <div class="form-group">
                      <textarea class="form-control" ref="body" id="body" placeholder="Enter a body" rows="8" required></textarea>
                    </div>

                    <div class="custom-file mb-3">
                        <label for="image" class="control-label">Post Image</label>
                        <br>
                        <input type="file"  @change="postImage" ref="image" name="image"  id="image" required>
                    </div>                 
                </div>
                <div class="modal-footer">
                    <button type="submit" @click.prevent="createPost" class="btn btn-primary block">
                      Create
                    </button>
                </div>    
                <div :class="['form-group m-1 p-3', (successful ? 'alert-success' : '')]">
                      <span v-if="successful" class="label label-sucess">Published!</span>
                </div>
                <div :class="['form-group m-1 p-3', error ? 'alert-danger' : '']">
                      <span v-if="errors.title" class="label label-danger">
                        {{ errors.title[0] }}
                      </span>
                      <span v-if="errors.body" class="label label-danger"> 
                        {{ errors.body[0] }} 
                      </span>
                      <span v-if="errors.image" class="label label-danger"> 
                        {{ errors.image[0] }} 
                      </span>
                </div>    
              </form>
              <form v-show="editmode" @submit.prevent="updatePost()">     
                <div class="modal-body">
                    <div class="form-group">
                        <input v-model="form.title" type="text" name="title"
                            placeholder="Title"
                            class="form-control" :class="{ 'is-invalid': form.errors.has('name') }">
                        <has-error :form="form" field="name"></has-error>
                    </div>

                     <div class="form-group">
                        <textarea style="height: 250px !important" v-model="form.body" type="text" name="body"
                            placeholder="Body"
                            class="form-control text-area" :class="{ 'is-invalid': form.errors.has('email') }"></textarea>
                        <has-error :form="form" field="email"></has-error>
                    </div>
                    
                    <div class="form-group">                   
                            <label for="image" class="control-label">Post Image</label>
                            <div>
                            <input type="file" @change="postImage" id="image" name="image" class="form-input">
                          </div>  
                    </div>

              
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                <button type="submit" v-show="editmode" class="btn btn-success">Update</button>
              </div>

             </form>    

            </div>
          </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
          return {
            error: false,
            successful: false,
            editmode: false,
            posts: {}, 
            form: new Form ({
                  id:'',
                  title : '',
                  body: '',
                  user_id: '',
                  image: '',
            })
          }
        },

        methods: {
            getResults(page = 1) {
              axios.get('api/post?page=' + page)
                .then(response => {
                  this.posts = response.data;
                });
            },

            //modals
            createModal() {
              this.editmode = false;
              $('#AddnewModal').modal('show');
              this.form.reset();
            },

            updateModal(post) {
              this.editmode = true;
              this.form.reset();
              $('#AddnewModal').modal('show');
              this.form.fill(post);
            },
            
            //create
            createPost() {
              this.$Progress.start();

              const formData = new FormData();
              formData.append("title", this.$refs.title.value);
              formData.append("body", this.$refs.body.value);
              formData.append("user_id", this.userId);
              formData.append("image", this.$refs.image.files[0]);
              axios
              .post("api/post", formData)
              .then(response => {
                  Fire.$emit('hasEvent');
                  $('#AddnewModal').modal('hide');

                  Toast.fire({
                    type: 'success',
                    title: 'User has been created successfully!!'
                  }) 
              this.$Progress.finish();
              })
              .catch(error => {
                if (!_.isEmpty(error.response)) {
                  if ((error.response.status = 422)) {
                    this.errors = error.response.data.errors;
                    this.successful = false;
                    this.error = true;
                  }
                  this.$Progress.fail();
                }
              });     
            },

            postImage(e){
                //base 64 method
                let file = e.target.files[0];
                let reader = new FileReader();
                // let limit = 1024 * 1024 * 2;
                if(file['size'] < 2111775){
                   reader.onloadend = (file) => {
                      this.form.image = reader.result;
                   }
                   reader.readAsDataURL(file);
                }else{
                    Swal.fire({
                        type: 'error',
                        title: 'Oops...',
                        text: 'You are uploading a large file',
                    })
                }
            },

            //update
            updatePost() {
                 this.$Progress.start();
                 this.form.patch('api/post/'+this.form.id)
                 .then(() => {
                    $('#AddnewModal').modal('hide');

                    Toast.fire({
                       type: 'success',
                       title: 'User has beed updated successfully!!'
                    })

                    this.$Progress.finish(); 
                    Fire.$emit('hasEvent'); 
                 })
                 .catch(() => {
                   this.$Progress.fail();
                 });
            },

            //load
            loadPosts() {
              if(this.$gate.isAdminOrMember()) {
                axios.get('api/post').then(({ data }) => (this.posts = data));
              }
              
            },

            //delete
            deletePost(id) {
                Swal.fire({
                  title: 'Are you sure?',
                  text: "You won't be able to revert this!",
                  type: 'warning',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes, delete it!'
                }).then((result) => {

                  if (result.value) {
                    this.form.delete('api/post/'+id).then(() => {
                      Fire.$emit('hasEvent');
                      Swal.fire(
                      'Deleted!',
                      'Your post has been deleted.',
                      'success'
                      )
                    }).catch(() => {
                      Swal.fire('Failed!!', 'something went worng', 'warning')
                    });
                    
                  }
                })                  
            }
        },
        created() {
            Fire.$on('searching',() => {
                let query = this.$parent.search;
                axios.get('api/findPost?q=' + query)
                .then((data) => {
                    this.posts = data.data
                })
                .catch(() => {

                })
            })

            this.loadPosts();
            //listen custom event
            Fire.$on('hasEvent', () => {
              this.loadPosts();
            })
        }
    }
</script>