abstract class Item {}

mixin Weapon on Item {
  int get damage;
}
mixin Armor on Item {
  int get defense;
}

mixin HeadEquipment on Item {}
mixin TorsoEquipment on Item {}
mixin LegEquipment on Item {}
mixin FootEquipment on Item {}

class Sword extends Item with Weapon {
  int damages;
  Sword({required this.damages});
  @override
  int get damage => damages;
}

class Bow extends Item with Weapon {
  final int damages;

  Bow({required this.damages});

  @override
  int get damage => damages;
}

class Helmet extends Item with Armor, HeadEquipment {
  final int defenses;

  Helmet({required this.defenses});

  @override
  int get defense => defenses;
}

class ChestPlate extends Item with Armor, TorsoEquipment {
  final int defenses;

  ChestPlate({required this.defenses});

  @override
  int get defense => defenses;
}

class Leggings extends Item with Armor, LegEquipment {
  final int defenses;

  Leggings({required this.defenses});

  @override
  int get defense => defenses;
}

class Boots extends Item with Armor, FootEquipment {
  final int defenses;

  Boots({required this.defenses});
  @override
  int get defense => defenses;
}

class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;
  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  int get damage {
    int totalDamage = 0;
    for (final item in equipped) {
      if (item is Weapon) {
        totalDamage += item.damage;
      }
    }
    return totalDamage;
  }

  int get defense {
    int totalDefence = 0;
    for (final item in equipped) {
      if (item is Armor) {
        totalDefence += item.defense;
      }
    }
    return totalDefence;
  }

  void equip(Item item) {
    if (item is Weapon) {
      if (leftHand == null) {
        leftHand = item;
        return;
      } else if (rightHand == null) {
        rightHand = item;
        return;
      } else {
        throw OverflowException();
      }
    }

    // Head
    if (item is HeadEquipment) {
      if (hat == null) {
        hat = item;
        return;
      } else {
        throw OverflowException();
      }
    }
    // foot
    if (item is FootEquipment) {
      if (shoes == null) {
        shoes = item;
        return;
      } else {
        throw OverflowException();
      }
    }

    // Leg
    if (item is LegEquipment) {
      if (legs == null) {
        legs = item;
        return;
      } else {
        throw OverflowException();
      }
    }

    // Torso
    if (item is TorsoEquipment) {
      if (torso == null) {
        torso = item;
        return;
      } else {
        throw OverflowException();
      }
    }

    throw ArgumentError('Cannot be equipped: ${item.runtimeType}');
  }
}

class OverflowException implements Exception {}

void main() {
  final character = Character();

  final sword = Sword(damages: 10);
  final bow = Bow(damages: 8);
  final helmet = Helmet(defenses: 5);
  final chestPlate = ChestPlate(defenses: 15);
  final leggings = Leggings(defenses: 10);
  final boots = Boots(defenses: 3);
  print('Result of damages and defences');
  print(character.damage);
  print(character.defense);

  try {
    character.equip(sword);
    character.equip(bow);
    character.equip(helmet);
    character.equip(chestPlate);
    character.equip(leggings);
    character.equip(boots);

    print('After equipping all items:');
    print(character.equipped);
  } catch (e) {
    print('Error: $e');
  }
}
