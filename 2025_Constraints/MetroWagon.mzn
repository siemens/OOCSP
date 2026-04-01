set of int: LengthMm = 10000..20000;
int: maxSeats = max(LengthMm)*4 div 1000;
set of int: Places = 50..200;
enum Colour = { blue, red, white };
enum Kind = { standard, premium, special };
set of Kind: HandrailKind = Kind diff { special };

class Wagon {
  LengthMm: lengthMm;
  Places: nrPlaces;
  0..max(Places): nrStanding;
  set(0..maxSeats) of new Seat: seats;
  int: nrSeats = card(seats);
  opt new Handrail: handrail;

  constraint nrSeats + nrStanding = nrPlaces;
  constraint nrSeats + nrStanding/3 <= lengthMm*4/1000;
  constraint nrStanding > 0 -> handrail != <>;
  constraint all_equal(s in seats where s.kind != special)(s.colour);
};

class InteriorComponent { Kind: kind; };

class Handrail extends InteriorComponent {
  HandrailKind: kind;
  set(1..3) of Seat: attached;
  Wagon: wagon;
  constraint forall(s in attached)(kind = s.kind);
};

class Seat extends InteriorComponent {
  Colour: colour;
  opt Handrail: handrail;
  Wagon: wagon;
  
  constraint if kind = special then colour = red endif;
};

constraint association(Seat.attached, Handrail.attached);
constraint association(Wagon.seats, Seat.wagon);
constraint association(Wagon.handrail, Handrail.wagon);

var new Wagon: w;
solve maximize w.nrPlaces/w.lengthMm; % load factor