create table writing_supply(
	supply_id int primary key auto_increment,
    utensil_type enum ("Pencil", "Pen"),
    num_drawers int
);

create table pencil_drawer(
	drawer_id int primary key auto_increment,
    pencil_type enum ("Wood", "Mechanical"),
    quantity int,
    refill bool,
    supply_id int,
    foreign key(supply_id) references writing_supply(supply_id)
);

create table pen_drawer(
	drawer_id int primary key auto_increment,
    color enum ("Black", "Blue", "Red", "Green", "Purple"),
    quantity int,
    refill bool,
    supply_id int,
    foreign key(supply_id) references writing_supply(supply_id)
)

select writing_supply.supply_id, pencil_type, drawer_id, quantity
from writing_supply
inner join pencil_drawer on writing_supply.supply_id = pencil_drawer.supply_id
where refill = true and pencil_type = "Mechanical";

select writing_supply.supply_id, utensil_type, drawer_id, quantity from writing_supply
left join pencil_drawer on writing_supply.supply_id = pencil_drawer.supply_id
where refill = true

union

select writing_supply.supply_id, utensil_type, drawer_id, quantity from writing_supply
right join pen_drawer on writing_supply.supply_id = pen_drawer.supply_id
where refill = true
order by supply_id;

select drawer_id, color from pen_drawer
where supply_id in (select max(supply_id) from writing_supply where utensil_type = "Pen") and quantity >= 60;