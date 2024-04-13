sealed class UpdateNameEvents {}

class UpdateName extends UpdateNameEvents {
  String firstName;
  String lastName;
  UpdateName(this.firstName, this.lastName);
}



