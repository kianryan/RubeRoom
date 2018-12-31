"The Rube Room" by Kian Ryan

The Machine Room is a room.  "A dark room.  A machine sits in the centre with a domed temple.  Doorways lead away in all four directions."


[Water Room - ]
[Implementation of the Jug Problem]
[Win condition is a single jug containing 4 litres of water]

[Create our new rules for this room.]
Filling is a object based rulebook.
A filling rule:
	let volume be the volume of the noun;
	now the capacity of the noun is volume; [We may only fill fully]

Emptying is an object based rulebook.
An emptying rule:
	now the capacity of the noun is 0; [We may only empty completely]

Transferring is an object based rulebook.
A transferring rule:
	let space be the volume of the second noun - the capacity of the second noun;
	let capacity be capacity of noun;
	let tofill be 0;
	if (capacity > space): [Set the amount we're going to fill based on the amount of space available]
		let tofill be space;
	otherwise:
		let tofill be capacity;
	now capacity of second noun is capacity of second noun + tofill;
	now capacity of noun is capacity of noun - tofill;

[Create kinds and associated actions]
[Start - amphoras]
A amphora is a kind of thing.
A amphora has a number called volume.  The volume of the amphora is usually 5.
A amphora has a number called capacity.  The capacity of the amphora is usually 0.

Before examining an amphora:
	let volume be the volume of the noun;
	let general be "A roman styled [noun] with a volume of [volume] litres.";
	if the capacity of the noun is 0:
		now the description of the noun is "[general]  The amphora is empty.";
	otherwise if the capacity of the noun >= volume of the noun:
		now the description of the noun is "[general]  The amphora is full.";
	otherwise:
		now the description of the noun is "[general]  The amphora is partially filled.";

[Empty amphoras - ]
Emptying is an action applying to one visible thing.
Understand "empty [something]" as emptying.
Understand "spill [something]" as emptying.

Check emptying:
	if the noun is not a amphora, say "What are you trying to empty?" instead.

Carry out emptying:
	if capacity of noun > 0:
		follow the emptying rules for the noun;
		say "You spill the contents on to the floor.  It splashes on the floor around your feet.";
	otherwise:
		say "There's nothing to empty."

[Transfering between amphoras - ]
Transferring is an action applying to two visible things.
Understand "transfer [something] to [something]" as transferring.
Understand "pour [something] in to [something]" as transferring.
Understand "pour [something] in [something]" as transferring.
Understand "pour [something] to [something]" as transferring.

Check transferring:
	if the noun is not a amphora and the second noun is not a amphora, say "You can only pour water between the amphoras.  Anything else is cheating, and who knows who may be watching?"

Carry out transferring:
	if capacity of noun is 0:
		say "Oh dear, looks like there's nothing in here to pour.";
	if capacity of second noun is volume of second noun:
		say "There's no space in the second amphora for you to pour in to.  It'll just pour on to the floor.";
	otherwise:
		say "You pour water from the [noun] to the [second noun].";
		follow the transferring rules for the noun.

[Compare amphora - we're not complete monsters -]
Comparing is an action applying to two visible things.
Understand "compare [something] to [something]" as comparing.

Check comparing:
	if the noun is not a amphora and the second noun is not a amphora, say "You can only compare amphoras.  Otherwise, whats the point?"

Carry out comparing:
	if capacity of noun is capacity of second noun:
		say "It's a close call - you're judging it by eye and ear alone, but they look pretty equal.";
	otherwise if capacity of second noun < capacity of noun:
		say "You're judging it by eye and ear, but you're pretty sure that the [noun] has more water than the [second noun].";
	otherwise:
		say "You're judging it by eye and ear, but you're pretty sure that the [noun] has less water than the [second noun]."
[End - amphoras]

[Start - scales]
A scale is a kind of supporter.
A scale usually has carrying capacity 1.

After putting something on the scale:
	if noun is amphora:
		let balance be 4;
		if capacity of noun is balance:
			say "Well done.";
		otherwise if capacity of noun < balance:
			say "The scales tip down.";
		otherwise:
			say "The scales tip up.";
	otherwise:
		say "The scales swing around a bit, but don't tell you anything useful."
[End - scales]

[Create the room, and the objects within the room.]
A room called The Water Room is north of the Machine Room.  "You hear the water before you enter the room.  As you walk in to the room, you see the water falling from a waterfall in to a small rock pool below."

A rock pool is here.  "The rock pool contains crystal clear water.  It is constantly refilled with water from the waterfall."
The rock pool is an open container.
The rock pool is fixed in place.

A amphora called large amphora is here.
The volume of the large amphora is 5.

A amphora called small amphora is here.
The volume of the small amphora is 3.

After inserting an amphora into the rock pool: [Filling amphoras in the rock pool]
	follow the filling rules for the noun;
	say "The amphora has filled to the brim with crystal clear water."

A scale called brass scale is here. "Brass scale".

[Fire room]
[A lights out (all lights on) problem]
[Win condition is all braziers being lit at the same time.]

[Create our new rules for this room.]

Toggling is an object based rulebook.
A toggling rule:
	if noun is lit: [Toggle the target]
		now noun is unlit;
		say "Pfft.";
	otherwise:
		now noun is lit;
		say "Woosh.";
	if left of noun is unlit: [Toggle the L/R of the target]
		now left of noun is lit;
	otherwise:
		now left of noun is unlit;
	if right of noun is unlit:
		now right of noun is lit;
	otherwise:
		now right of noun is unlit;
	follow brazier winning rule;

This is the brazier winning rule: [Have we won yet?]
	if all braziers are lit:
		say "Well done."

Instead of burning a brazier:
	if noun is lit:
		say "This brazier is already lit...";
	otherwise:
		follow toggling rules for noun;
		say "[left of noun] [noun] [right of noun]";

[Create kinds and associated actions]
A brazier is a kind of lit thing.
A brazier is fixed in place.
A brazier is usually unlit.
A brazier has a brazier called left.
A brazier has a brazier called right.

After printing the name of a lit brazier, say " (lit)".
After printing the name of an unlit brazier, say " (unlit)".

Snuffing is an action applying to one visible thing.
Understand "snuff [something]" as snuffing.
Understand "extinguish [something]" as snuffing.

Check snuffing:
	if the noun is not an brazier, say "What on earth are you trying to snuff?" instead;
	if the noun is not lit, say "But the brazier is not lit." instead.

Carry out snuffing:
	follow toggling rules for noun;
	say "[left of noun] [noun] [right of noun]".

[Create the room, and the objects within the room.]
A room called The Fire Room is south of the Machine Room.  "You feel the temperature noticeably rise as you enter the room and smell oil in your nostrils.  You see five oil braziers on pedastals arranged in a circle."

A brazier called first brazier is here.
A brazier called second brazier is here.
A brazier called third brazier is here.  Third brazier is lit.
A brazier called fourth brazier is here.  Fourth brazier is lit.
A brazier called fifth brazier is here.  Fifth brazier is lit.

The left of first brazier is fifth brazier.  The right of first brazier is second brazier.
The left of second brazier is first brazier.  The right of second brazier is third brazier.
The left of third brazier is second brazier.  The right of third brazier is fourth brazier.
The left of fourth brazier is third brazier.  The right of fourth brazier is fifth brazier.
The left of fifth brazier is fourth brazier.  The right of fifth brazier is first brazier.