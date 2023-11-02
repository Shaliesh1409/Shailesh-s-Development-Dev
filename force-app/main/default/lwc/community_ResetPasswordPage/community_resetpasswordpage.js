import { LightningElement, track } from 'lwc';

export default class Community_ResetPasswordPage extends LightningElement {
    @track roleOptions = [
        { label: 'Teacher', value: 'teacher' },
        { label: 'Student', value: 'student' }
    ];

    @track selectedRole = 'teacher'; // Default to 'Teacher'
    @track email = '';
    @track newPassword = '';
    @track reEnterNewPassword = '';

    handleRoleChange(event) {
        this.selectedRole = event.detail.value;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleNewPasswordChange(event) {
        this.newPassword = event.target.value;
    }

    handleReEnterNewPasswordChange(event) {
        this.reEnterNewPassword = event.target.value;
    }

    handleResetPassword() {
        // Implement password reset logic here
        console.log('Reset Password button clicked');
        console.log('Selected Role: ' + this.selectedRole);
        console.log('Email: ' + this.email);
        console.log('New Password: ' + this.newPassword);
    }
}
