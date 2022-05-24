class FoodModel {
  String name;
  int kal;
  int portion;
  double k;
  double l;
  double p;
  double g;
  double s;

  FoodModel(this.name, this.kal, this.portion, this.k, this.l, this.p, this.g,
      this.s);

  String get getName {
    return name;
  }

  int get getkal {
    return kal;
  }

  int get getportion {
    return portion;
  }

  double get getK {
    return k;
  }

  double get getL {
    return l;
  }

  double get getP {
    return p;
  }

  double get getG {
    return g;
  }

  double get getS {
    return s;
  }
}
