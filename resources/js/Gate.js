export default class Gate{

    constructor(user){
        this.user = user;
    }


    isAdmin(){
        return this.user.type === 'admin';
    }

    isMember(){
        return this.user.type === 'member';
    }

    isUser(){
        return this.user.type === 'user';
    }

    isAdminOrMember(){
        if(this.user.type === 'admin' || this.user.type === 'member'){
            return true;
        }
    }

}