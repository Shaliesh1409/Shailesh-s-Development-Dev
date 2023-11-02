import { LightningElement, track } from 'lwc';
import doLogin from '@salesforce/apex/CommunityAuthController.doLogin';


export default class LoginComponent extends LightningElement {


    username;
    password;
    @track errorCheck;
    @track errorMessage;

    connectedCallback(){

        var meta = document.createElement("meta");
        meta.setAttribute("name", "viewport");
        meta.setAttribute("content", "width=device-width, initial-scale=1.0");
        document.getElementsByTagName('head')[0].appendChild(meta);
    }

    handleUserNameChange(event){

        this.username = event.target.value;
    }

    handlePasswordChange(event){
        
        this.password = event.target.value;
    }

    handleLogin(event){

       if(this.username && this.password){

        event.preventDefault();

        doLogin({ username: this.username, password: this.password })
            .then((result) => {
                
                window.location.href = "/studentportal/s/"; 
            })
            .catch((error) => {
                this.error = error;      
                this.errorCheck = true;
                this.errorMessage = error.body.message;
            });

        }

    }
}

// import { LightningElement, track } from 'lwc';

// export default class LoginPage extends LightningElement {
//     @track selectedRole = 'Student';
//     @track username = '';
//     @track password = '';

//     roleOptions = [
//         { label: 'Student', value: 'Student' },
//         { label: 'Teacher', value: 'Teacher' }
//     ];

//     handleRoleChange(event) {
//         this.selectedRole = event.detail.value;
//     }

//     handleUsernameChange(event) {
//         this.username = event.target.value;
//     }

//     handlePasswordChange(event) {
//         this.password = event.target.value;
//     }

//     handleLogin() {
//         // Implement user authentication logic here
//         // Check the entered credentials and user role (this.selectedRole)
//         // Authenticate the user and navigate to the appropriate dashboard
//         // You may use Apex methods to perform these actions
//     }
// }
