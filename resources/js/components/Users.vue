<template>
    <div class="container">
      <div class="row">
        <div class="col-md-12 mt-5" v-if="$gate.isAdmin()">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Users List</h3>

                <div class="card-tools">
                  <button class="btn btn-success" @click="createModal"> Add New
                    <i class="fas fa-user-plus fa-fw"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Type</th>
                      <th>Registered At</th>
                      <th>Edit/Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="user in users" :key = "user.id">
                      <td>{{user.id}}</td>
                      <td>{{user.name}}</td>
                      <td>{{user.email}}</td>
                      <td>{{user.type | upText }}</td>
                      <td>{{user.created_at | myDate }}</td>
                      <td>
                          <a href="#" @click="updateModal(user)">
                              <i class="fa fa-edit blue fa-fw"></i>
                          </a>
                          /
                          <a href="#" @click="deleteUser(user.id)">
                              <i class="fa fa-trash red fa-fw"></i>
                          </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
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
                <h5 class="modal-title" v-show="!editmode" id="AddnewModalLabel">Add New User</h5>
                <h5 class="modal-title" v-show="editmode" id="AddnewModalLabel">Update User Info:</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>

              <form @submit.prevent=" editmode ? updateUser() :createUser()">     
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
                        <select name="type" v-model="form.type" id="type" class="form-control" :class="{ 'is-invalid': form.errors.has('type') }">
                            <option value="">Select User Role</option>
                            <option value="admin">Admin</option>
                            <option value="user">Free User</option>
                            <option value="member">Premium User</option>
                        </select>
                        <has-error :form="form" field="type"></has-error>
                    </div>

                    <div class="form-group">
                        <input type="password"  name="password" id="password"
                        class="form-control mb-3" placeholder="Enter Password" :class="{ 'is-invalid': form.errors.has('password') }">
                        <has-error :form="form" field="password"></has-error>
                        <input v-model="form.password" type="password"  name="confirm_password" id="confirm_password"
                        class="form-control" placeholder="Confirm Password" :class="{ 'is-invalid': form.errors.has('confirm_password') }">
                        <has-error :form="form" field="confirm_password"></has-error>
                    </div>
              
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                <button type="submit" v-show="editmode" class="btn btn-success">Update</button>
                <button type="submit" v-show="!editmode" class="btn btn-primary">Create</button>
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
            //modals
            createModal() {
              this.editmode = false;
              this.form.reset();
              $('#AddnewModal').modal('show');
            },

            updateModal(user) {
              this.editmode = true;
              this.form.reset();
              $('#AddnewModal').modal('show');
              this.form.fill(user);
            },
            
            //create
            createUser() {
              this.$Progress.start();
              this.form.post('api/user')
              .then(() => {
                  //custom events
                  Fire.$emit('hasEvent');

                  $('#AddnewModal').modal('hide');

                  Toast.fire({
                    type: 'success',
                    title: 'User has been created successfully!!'
                  }) 

                 this.$Progress.finish();
              })
              .catch(() => {
                  this.$Progress.fail();
              });
              
            },

            //update
            updateUser() {
                 this.$Progress.start();
                 this.form.patch('api/user/'+this.form.id)
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
            loadUsers() {
              if(this.$gate.isAdmin) {
                  axios.get('api/user').then(({ data }) => (this.users = data.data));
              }   
            },

            //delete
            deleteUser(id) {
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
                    this.form.delete('api/user/'+id).then(() => {
                      Fire.$emit('hasEvent');
                      Swal.fire(
                      'Deleted!',
                      'Your file has been deleted.',
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
            this.loadUsers();
            //listen custom event
            Fire.$on('hasEvent', () => {
              this.loadUsers();
            })
        }
    }
</script>