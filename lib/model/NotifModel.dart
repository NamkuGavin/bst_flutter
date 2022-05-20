class NotifModel {
  String name;
  String time;
  String desc;
  bool status;
  int type;

  NotifModel(this.name, this.time, this.desc, this.status, this.type);

  String get getName{
    return name;
  }
  String get getTime{
    return time;
  }
  String get getdesc{
    return desc;
  }
  bool get getStatus{
    return status;
  }
  int get getType{
    return type;
  }


  // set setName(String name){
  //   this.name = name;
  // }
  // set setTime(String time){
  //   this.time = time;
  // }
  // set setDesc(String desc){
  //   this.desc = desc;
  // }
  // set setStatus(bool status){
  //   this.status = status;
  // }
  // set setType(int type){
  //   this.type = type;
  // }


}

