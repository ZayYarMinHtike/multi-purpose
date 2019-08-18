<template>
    <div class="container">
        <div class="row justify-content-center">
                 <div class="col-md-6">
                         <div class="card card-primary card-outline mt-5">
                            <div class="card-body box-profile">
                                <div class="text-center">
                                      <img class="profile-user-img img-fluid img-circle" src="/storage/images/profile-img/profile.png" alt="User profile picture">
                                </div>
                    
                                    <h3 class="profile-username text-center">{{ form.name }}</h3>
                    
                                    <p class="text-muted text-center">{{ form.type }}</p>
                    
                                    <ul class="list-group list-group-unbordered mb-3">
                                      <li class="list-group-item">
                                        <b>Email :</b> <p>{{ form.email }}</p>
                                      </li>
                                      <li class="list-group-item">
                                        <b>User Biography :</b> <p>{{ form.bio }}</p>
                                      </li>
                                    </ul>
                    
                                    <div class="card-footer d-flex justify-content-center">
                                      <button type="submit" class="btn btn-success mr-1" data-toggle="modal" data-target="#profileModal">Update Profile</button>
                                      <button type="submit" class="btn btn-danger ml-1">Reset Password</button>
                                    </div>                      
                                  </div>
                                  <!-- /.card-body -->                              
                         </div><!-- /.profile-body -->    

                         
                         <div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel" aria-hidden="true">
                           <div class="modal-dialog modal-dialog-centered" role="document">
                             <div class="modal-content">
                               <div class="modal-header">
                                 <h5 class="modal-title" id="profileModalLabel">Update Profile</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                   <span aria-hidden="true">&times;</span>
                                 </button>
                               </div>
                                <form>
                                  <div class="modal-body">
                                     <div class="form-group">
                                         <input v-model="form.name" type="text" name="name"
                                             placeholder="Name"
                                             class="form-control" :class="{ 'is-invalid': form.errors.has('name') }">
                                         <has-error :form="form" field="name"></has-error>
                                     </div>
                 
                                      <div class="form-group">
                                         <input v-model="form.email" type="email" name="email"
                                             placeholder="Email Address"
                                             class="form-control" :class="{ 'is-invalid': form.errors.has('email') }">
                                         <has-error :form="form" field="email"></has-error>
                                     </div>
                 
                                      <div class="form-group">
                                         <textarea v-model="form.bio" name="bio" id="bio"
                                         placeholder="Short bio for user (Optional)"
                                         class="form-control" :class="{ 'is-invalid': form.errors.has('bio') }"></textarea>
                                         <has-error :form="form" field="bio"></has-error>
                                     </div>
                 
                                     <div class="form-group">
                                        <label for="photo" class="control-label">Profile Photo</label>
                                          <div>
                                            <input type="file" @change="updateProfile" name="photo" class="form-input">
                                          </div>

                                     </div>
                 
                                     <div class="form-group">
                                         <input v-model="form.password" type="password" name="password" id="password"
                                         class="form-control" placeholder="Enter Password" :class="{ 'is-invalid': form.errors.has('password') }">
                                         <has-error :form="form" field="password"></has-error>
                                     </div>                 
                                  </div> <!-- /.modal-body-->
                                </form>  
                               <div class="modal-footer">
                                 <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                 <button type="submit" class="btn btn-success" @click.prevent="updateInfo">Update</button>
                               </div>
                             </div>
                           </div>
                         </div>                                              
                 </div>
        </div>
    </div>
</template>



<script>
export default {
        data() {
          return {
             editmode: false,
             users: {}, 
             form: new Form ({
                  id:'',
                  name : '',
                  email: '',
                  password: '',
                  type: '',
                  bio: '',
                  photo: '',
            })
          }
        },
        methods: {
            loadUsers() {
              axios.get('api/profile')
              .then(({ data }) => (this.form.fill(data)));
            },

            updateInfo() {
                this.form.patch('api/profile').then(() => {

                })
                .catch(() => {

                });
            },

            updateProfile(e){

                //base 64 method
                let file = e.target.files[0];
                let reader = new FileReader();

                // let limit = 1024 * 1024 * 2;
                // if(file['size'] > limit){
                //     swal({
                //         type: 'error',
                //         title: 'Oops...',
                //         text: 'You are uploading a large file',
                //     })
                //     return false;
                // }

                reader.onloadend = (file) => {
                    this.form.photo = reader.result;
                }
                reader.readAsDataURL(file);
            }
        },
        created() {
            this.loadUsers();
            //listen custom event
            // Fire.$on('hasEvent', () => {
            //   this.loadUsers();
            // })
        }
}
</script>
