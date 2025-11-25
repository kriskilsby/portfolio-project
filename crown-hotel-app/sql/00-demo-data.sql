-- insert demo room data
SET SCHEMA 'hotelbooking';

INSERT INTO room (r_no, r_class, r_status, r_notes) VALUES
(101, 'sup_d', 'A', 'demo data'),
(102, 'sup_d', 'O', 'demo data'),
(103, 'std_d', 'O', 'demo data'),
(104, 'std_d', 'O', 'demo data'),
(105, 'std_d', 'O', 'demo data'),
(106, 'std_t', 'O', 'demo data'),
(107, 'std_t', 'O', 'demo data'),
(108, 'std_t', 'O', 'demo data'),
(201, 'sup_d', 'O', 'demo data'),
(202, 'sup_d', 'O', 'demo data'),
(203, 'sup_d', 'O', 'demo data'),
(204, 'std_t', 'O', 'demo data'),
(205, 'std_t', 'O', 'demo data'),
(206, 'std_t', 'O', 'demo data'),
(207, 'std_t', 'O', 'demo data'),
(208, 'sup_t', 'O', 'demo data'),
(209, 'sup_t', 'C', 'demo data'),
(210, 'sup_t', 'O', 'demo data'),
(211, 'std_d', 'O', 'demo data'),
(212, 'std_d', 'O', 'demo data'),
(301, 'std_d', 'O', 'demo data'),
(302, 'std_d', 'O', 'demo data'),
(303, 'sup_d', 'O', 'demo data'),
(304, 'sup_d', 'O', 'demo data'),
(305, 'sup_d', 'O', 'demo data'),
(306, 'sup_d', 'A', 'demo data'),
(307, 'sup_t', 'O', 'demo data'),
(308, 'sup_t', 'C', 'demo data'),
(309, 'sup_t', 'A', 'demo data'),
(310, 'sup_t', 'A', 'demo data'),
(311, 'sup_t', 'A', 'demo data'),
(312, 'sup_t', 'O', 'demo data');


SELECT * FROM hotelbooking.room;

-- insert demo rates data
set schema 'hotelbooking';
insert into rates values ('std_t', 62);
insert into rates values ('std_d', 65);
insert into rates values ('sup_t', 75);
insert into rates values ('sup_d', 77);

SELECT * FROM hotelbooking.rates;


-- ################ PORTFOLIO DEMO DATA ####################################################
-- Customer insert - batch 1
BEGIN;
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (50, 'Irene Russell', 'irene.russell@hotmail.com', '1A Carent Close,  Marnhull, DT10 1LJ', 'V', '02/26', '2221929723497350');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (51, 'Andrea Poole', 'andrea.poole@hotmail.com', '1 Ireleth Road,  Askam-In-Furness, LA16 7AR', 'MC', '10/25', '5552438247871760');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (52, 'Jonathan Gibson', 'jonathan.gibson@hotmail.com', '1 Gladstone Road,  Kingston Upon Thames, KT1 3HD', 'A', '09/26', '2309928390850660');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (53, 'Lillian Mathis', 'lillian.mathis@hotmail.com', 'Casey Cottage,  Sandon, ST18 0BY', 'V', '04/26', '5407634717176670');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (54, 'Colin Lambert', 'colin.lambert@hotmail.com', 'Hafod-Y-Grug,  Castle Lane,  Aberaeron, SA46 0AB', 'MC', '10/25', '2221811193873570');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (55, 'Jane Allan', 'jane.allan@hotmail.com', '46 Egremont Promenade,  Wallasey, CH44 8BQ', 'A', '09/25', '2221464992600160');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (56, 'Neil Campbell', 'neil.campbell@hotmail.com', '52 Lower Kewstoke Road,  Worle, BS22 9JU', 'V', '10/26', '2568158263029720');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (57, 'Melanie Harris', 'melanie.harris@hotmail.com', 'The Old School,  Mitchell, TR8 5BZ', 'MC', '02/26', '5502832502579350');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (58, 'Sean Miller', 'sean.miller@hotmail.com', '11 Hogarth End,  Kirby Cross, CO13 0TY', 'A', '03/28', '2611914908270440');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (59, 'Bella Hardacre', 'bella.hardacre@hotmail.com', 'Flat 3,  Orchard Lodge,  Old Church Lane,  London, NW9 8TE', 'V', '06/26', '2368084102841800');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (60, 'Harry Lawrence', 'harry.lawrence@hotmail.com', '6 Godbold Close,  Kesgrave, IP5 2FE', 'MC', '11/26', '2304929827119830');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (61, 'Joseph Dickens', 'joseph.dickens@hotmail.com', 'Flat 3,  130 High Street,  Uckfield, TN22 1QR', 'A', '09/25', '2720305547907840');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (62, 'Joseph Parr', 'joseph.parr@hotmail.com', '9 St Davids Road,  Weymouth, DT4 9LR', 'V', '07/25', '2221037953834360');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (63, 'Emma Bower', 'emma.bower@hotmail.com', '3 Danebury Way,  Nursling, SO16 0YF', 'MC', '04/28', '2622666197016540');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (64, 'Vanessa Dyer', 'vanessa.dyer@hotmail.com', '14 Wallin Road,  Adderbury, OX17 3FA', 'A', '09/26', '5203477095168710');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (65, 'Michael Watson', 'michael.watson@hotmail.com', '10 St Josephs Gardens,  Carlisle, CA1 2UQ', 'V', '08/27', '2520080199706150');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (66, 'Liam Lee', 'liam.lee@hotmail.com', '16 Home Mead,  Corsham, SN13 9UB', 'MC', '02/28', '5402055905737960');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (67, 'Diane Baker', 'diane.baker@hotmail.com', '24 Saddleback Close,  Kingsnorth, TN25 7LP', 'A', '01/26', '2303286209889480');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (68, 'Trevor Vance', 'trevor.vance@hotmail.com', '5 Typhoon House,  Hangar Drive,  Tangmere, PO20 2BE', 'V', '07/26', '2720800159774950');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (69, 'Joshua Jones', 'joshua.jones@hotmail.com', '256 Pickering Road,  Hull, HU4 7AB', 'MC', '03/27', '5454299667480340');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (70, 'Felicity Lewis', 'felicity.lewis@hotmail.com', '11 Belgrave Street,  Heywood, OL10 3BN', 'A', '06/27', '2610616627889950');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (71, 'Leah Roberts', 'leah.roberts@hotmail.com', '61 Dean Street,  Failsworth, M35 0DQ', 'V', '09/26', '2577067653456700');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (72, 'Mary Dyer', 'mary.dyer@hotmail.com', '37 Vanbrugh Park,  London, SE3 7AA', 'MC', '05/27', '2221348410553410');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (73, 'Max Rampling', 'max.rampling@hotmail.com', 'Brackenside,  Pilgrims Way,  Chartham Hatch, CT4 7LR', 'A', '07/25', '2720656352022480');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (74, 'Sonia McDonald', 'sonia.mcdonald@hotmail.com', '5 Finches Close,  Stapleford, CB22 5BL', 'V', '10/26', '5125445284409670');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (75, 'Nicola Murray', 'nicola.murray@hotmail.com', '121 Oxford Street,  Stoke-On-Trent, ST4 7EJ', 'MC', '04/27', '5512327479805210');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (76, 'Jack Powell', 'jack.powell@hotmail.com', '15 Rendlesham,  Woolstone, MK15 0BB', 'A', '02/28', '2603780432574100');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (77, 'Emily Scott', 'emily.scott@hotmail.com', '11A Natal Road,  Ilford, IG1 2HA', 'V', '01/28', '5281396030542670');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (78, 'Eric Springer', 'eric.springer@hotmail.com', '32 Saxifrage Close,  Tharston, NR15 2ZU', 'MC', '12/27', '5401129522336380');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (79, 'Joseph Reid', 'joseph.reid@hotmail.com', 'Flat 5,  103A Highfield Lane,  Southampton, SO17 1NJ', 'A', '03/26', '2372007149376240');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (80, 'Molly Allan', 'molly.allan@hotmail.com', '11 Willen Park Avenue,  Willen Park, MK15 9HF', 'V', '04/27', '2675321926690060');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (81, 'Christopher Anderson', 'christopher.anderson@hotmail.com', '65 Heol Powis,  Cardiff, CF14 4PH', 'MC', '06/25', '2221354864255840');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (82, 'Julian Anderson', 'julian.anderson@hotmail.com', '51 Aberdeen Tower,  Sunderland, SR3 3AR', 'A', '08/26', '2353385491175840');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (83, 'Colin Newman', 'colin.newman@hotmail.com', '2 Granville Road,  Stoke-On-Trent, ST2 8LS', 'V', '08/27', '5313355692873070');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (84, 'Benjamin Wallace', 'benjamin.wallace@hotmail.com', '141 Highfield Road,  Tipton, DY4 0QT', 'MC', '07/26', '2527699042629370');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (85, 'Neil Fisher', 'neil.fisher@hotmail.com', '4 Penhale Gardens,  Holsworthy, EX22 6FX', 'A', '06/26', '2720366330843530');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (86, 'Leonard McGrath', 'leonard.mcgrath@hotmail.com', '11 Dockers Close,  Balsall Common, CV7 7EH', 'V', '02/27', '2607200681518620');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (87, 'Leah King', 'leah.king@hotmail.com', '92 Tividale Road,  Tividale, B69 2LQ', 'MC', '07/25', '5207221593537350');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (88, 'Pippa Davies', 'pippa.davies@hotmail.com', '7A Haydock Close,  Chester, CH1 4QB', 'A', '01/27', '5555225981639900');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (89, 'Stephanie Brown', 'stephanie.brown@hotmail.com', '180 Farnborough Road,  Castle Vale, B35 7NF', 'V', '07/27', '5210788849721960');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (90, 'Steven Murray', 'steven.murray@hotmail.com', '1 Shoeluck Cottages,  Church Lane,  Abridge, RM4 1AB', 'MC', '01/27', '5235548909462560');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (91, 'Dominic Brown', 'dominic.brown@hotmail.com', '10 Alexandra Terrace,  Tiverton, EX16 5JS', 'A', '07/26', '5427048396427590');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (92, 'Thomas Blake', 'thomas.blake@hotmail.com', '31 Firbank Road,  Dawlish, EX7 0NW', 'V', '04/27', '5179899252976530');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (93, 'Donna Hughes', 'donna.hughes@hotmail.com', '4 Manor Walk,  Holt, NR25 6DW', 'MC', '11/27', '5308021037894430');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (94, 'Gordon Quinn', 'gordon.quinn@hotmail.com', 'Cranmer Cottage,  Ramsbury, SN8 2PN', 'A', '03/28', '2658053998588830');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (95, 'Molly Gray', 'molly.gray@hotmail.com', '15 Brooklands Avenue,  Broughton, DN20 0DT', 'V', '07/26', '2451182537358890');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (96, 'Una Metcalfe', 'una.metcalfe@hotmail.com', 'Lee Valley,  Picketts Lock Lane,  London, N9 0AS', 'MC', '05/25', '2596643595532020');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (97, 'Lily Simpson', 'lily.simpson@hotmail.com', '72 Strand Street,  Sandwich, CT13 9HX', 'A', '07/25', '2400191808913870');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (98, 'Vanessa Cornish', 'vanessa.cornish@hotmail.com', '1 Yewtree Close,  Little Neston, CH64 4ES', 'V', '10/26', '5233294580484050');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (99, 'Nicholas Tucker', 'nicholas.tucker@hotmail.com', '8 Galloway Cross,  Crosby, CA15 6AL', 'MC', '05/25', '5512858403440500');

COMMIT;

-- Customer insert - batch 2
BEGIN;
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (100, 'Amelia Murray', 'amelia.murray@hotmail.com', '8 Pye Nook,  Low Moor, BD12 0HD', 'A', '11/25', '5289907092849420');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (101, 'Ruth Butler', 'ruth.butler@hotmail.com', 'Burn Cottage,  Beltingham,  Bardon Mill, NE47 7BT', 'V', '09/25', '2598009585081270');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (102, 'Elizabeth Graham', 'elizabeth.graham@hotmail.com', 'Hollowbrook Cottage,  Martinhoe,  Parracombe, EX31 4QT', 'MC', '11/26', '5476940050366750');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (103, 'Virginia Mackay', 'virginia.mackay@hotmail.com', 'Llwyn Ynn Cottage,  Talybont, LL43 2AH', 'A', '10/27', '2720317531622000');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (104, 'Caroline Paige', 'caroline.paige@hotmail.com', 'Three Dormers,  Russell Road,  Shepperton, TW17 9HJ', 'V', '05/27', '5465204789245580');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (105, 'Frank Berry', 'frank.berry@hotmail.com', 'Woodham Mead,  Rectory Road,  Woodham Walter, CM9 6RE', 'MC', '03/27', '5352398443773430');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (106, 'Sophie Carr', 'sophie.carr@hotmail.com', 'Craven Keep,  41 Park Lane,  Hamstead Marshall, RG20 0JQ', 'A', '07/27', '2513221526876950');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (107, 'Carol Harris', 'carol.harris@hotmail.com', '3 Pentre Terrace,  Boncath, SA37 0JN', 'V', '01/28', '5280905858538500');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (108, 'Caroline Lawrence', 'caroline.lawrence@hotmail.com', 'Unit 1-2,  Trackside Business Centre,  Abbot Close,  Byfleet, KT14 7NR', 'MC', '06/27', '2221740419928580');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (109, 'Rachel Campbell', 'rachel.campbell@hotmail.com', '1 Crabtree Cottages,  Cunsey, LA22 0LX', 'A', '01/27', '5425087211835070');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (110, 'Andrew Mackay', 'andrew.mackay@hotmail.com', 'Queen Mary House,  Manor Park Road,  Chislehurst, BR7 5PY', 'V', '02/26', '5136899088813050');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (111, 'Wanda Harris', 'wanda.harris@hotmail.com', '3 Higher Tolbury,  Bruton, BA10 0DJ', 'MC', '07/25', '2440584719761740');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (112, 'Una Clark', 'una.clark@hotmail.com', '2 Park Terrace,  Welshpool, SY21 7LL', 'A', '12/27', '2221552426059860');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (113, 'Jessica Clarkson', 'jessica.clarkson@hotmail.com', '7 Donibristle Croft,  Birmingham, B35 6BL', 'V', '11/26', '2221670213259210');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (114, 'Olivia Wilson', 'olivia.wilson@hotmail.com', '4 Whitriggs Close,  Millom, LA18 4EL', 'MC', '05/28', '2221442495364120');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (115, 'Matt Mathis', 'matt.mathis@hotmail.com', '2 Church Street,  St Erth, TR27 6HP', 'A', '07/27', '2697932711661280');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (116, 'Claire Mackenzie', 'claire.mackenzie@hotmail.com', '2 New Row,  Kirby Grindalythe, YO17 8DE', 'V', '04/26', '2221272341612680');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (117, 'Sarah Howard', 'sarah.howard@hotmail.com', '3 Apsley Road,  Cirencester, GL7 1SS', 'MC', '07/27', '2221501654486820');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (118, 'Steven Langdon', 'steven.langdon@hotmail.com', '3 Ashridge Close,  New Marske, TS11 8DY', 'A', '09/25', '2613120428854420');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (119, 'Jennifer Peters', 'jennifer.peters@hotmail.com', '58 Bowstoke Road,  Great Barr, B43 5DP', 'V', '04/27', '2386271480585040');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (120, 'Gabrielle Lewis', 'gabrielle.lewis@hotmail.com', '28 St Johns Street,  Bedford, MK42 0DH', 'MC', '02/26', '5325532578752880');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (121, 'Fiona Marshall', 'fiona.marshall@hotmail.com', '59 Sydney Road,  Bexleyheath, DA6 8HQ', 'A', '11/26', '2720051184683190');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (122, 'Sally Roberts', 'sally.roberts@hotmail.com', '65 Sandy Lane,  Middleton, M24 2TU', 'V', '12/27', '2413128883342580');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (123, 'Trevor Burgess', 'trevor.burgess@hotmail.com', '18 Breething Road,  Dunton Green, TN14 5GU', 'MC', '10/27', '5105427804885260');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (124, 'Max Bell', 'max.bell@hotmail.com', 'Pavement Hill,  The Green,  Sheriff Hutton, YO60 6SA', 'A', '07/25', '5471210823057350');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (125, 'Harry Manning', 'harry.manning@hotmail.com', '27 Morton Road,  Mexborough, S64 0DR', 'V', '01/27', '2681609771293160');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (126, 'Andrew Mitchell', 'andrew.mitchell@hotmail.com', '15 Boleyn Gardens,  West Wickham, BR4 9NG', 'MC', '05/25', '2221442112392510');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (127, 'Nicholas Piper', 'nicholas.piper@hotmail.com', 'Flat 1,  Belle View House,  5 The Grange,  Yeovil, BA21 5TN', 'A', '07/27', '2221614376573210');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (128, 'Deirdre Ferguson', 'deirdre.ferguson@hotmail.com', '15 Furze Close,  Mistley, CO11 2QQ', 'V', '01/26', '2221710631372020');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (129, 'Phil Baker', 'phil.baker@hotmail.com', '65 Albert Road,  Retford, DN22 6HZ', 'MC', '08/27', '5162293573110400');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (130, 'Bernadette Parr', 'bernadette.parr@hotmail.com', '21 Keats Way,  Coulsdon, CR5 3FL', 'A', '05/27', '5444838134309670');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (131, 'Diana Lewis', 'diana.lewis@hotmail.com', '28 Sea Crest Road,  Newbiggin-By-The-Sea, NE64 6BW', 'V', '07/27', '2429679948072450');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (132, 'Carolyn Ince', 'carolyn.ince@hotmail.com', '81 Kneeton Road,  East Bridgford, NG13 8PH', 'MC', '06/26', '2720257167041650');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (133, 'Alexandra Miller', 'alexandra.miller@hotmail.com', '225 Westway,  London, W12 7AP', 'A', '10/25', '2221627005673880');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (134, 'Dan Clarkson', 'dan.clarkson@hotmail.com', '2 Swinburne Street,  Blyth, NE24 4SP', 'V', '08/25', '2221514389087120');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (135, 'Blake Ball', 'blake.ball@hotmail.com', '11 Stanhope Mews South,  London, SW7 4TF', 'MC', '10/26', '2414787730212760');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (136, 'Abigail Rees', 'abigail.rees@hotmail.com', '2 Bunkers Hill,  Girton, CB3 0LY', 'A', '02/27', '2432960360512410');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (137, 'Joe North', 'joe.north@hotmail.com', '18 Dene Grove,  Prudhoe, NE42 6NB', 'V', '11/27', '2396118929647400');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (138, 'Angela Ince', 'angela.ince@hotmail.com', 'Oak Tree Farm,  The Moor,  Reepham, NR10 4NL', 'MC', '03/28', '2388626956490380');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (139, 'Jennifer Mackenzie', 'jennifer.mackenzie@hotmail.com', 'Walnut Tree Cottage,  Boreley Lane,  Ombersley, WR9 0HZ', 'A', '03/28', '5250266283446930');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (140, 'Benjamin Forsyth', 'benjamin.forsyth@hotmail.com', '8 Francis Reed Close,  Westonzoyland, TA7 0HS', 'V', '09/25', '2221992021341790');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (141, 'Zoe Gill', 'zoe.gill@hotmail.com', 'Inglewood,  3 Gatewick Lane,  Caldecotte, MK7 8LU', 'MC', '03/27', '2462472190739590');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (142, 'Donna Quinn', 'donna.quinn@hotmail.com', 'Linthorpe,  Swan Road,  Pewsey, SN9 5HH', 'A', '04/28', '5501332282190860');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (143, 'Lily Metcalfe', 'lily.metcalfe@hotmail.com', 'Sunrae,  Peaseland Green,  Elsing, NR20 3DY', 'V', '05/26', '5414032285806740');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (144, 'Melanie May', 'melanie.may@hotmail.com', '16 George Court,  Ashfield Drive,  Letchworth Garden City, SG6 1GU', 'MC', '09/27', '2558923645402630');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (145, 'Megan Rees', 'megan.rees@hotmail.com', '6 Oakfield Lane,  Waltham, DN37 0BN', 'A', '06/27', '5451310398263680');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (146, 'Nathan Reid', 'nathan.reid@hotmail.com', '12 Mayfield Terrace,  Warsop, NG20 0LE', 'V', '02/28', '2405696362812780');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (147, 'Vanessa Vance', 'vanessa.vance@hotmail.com', '141 Upperthorpe Road,  Sheffield, S6 3EB', 'MC', '01/27', '2221102573943590');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (148, 'Sophie Hardacre', 'sophie.hardacre@hotmail.com', '15 The Stokes,  Walton On The Naze, CO14 8RH', 'A', '10/26', '2562654983461240');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (149, 'Sam Morrison', 'sam.morrison@hotmail.com', 'Rose Cottage,  Aston Lane,  Oker, DE4 2JP', 'V', '12/27', '2589186171385760');

COMMIT;

-- Customer insert - batch 3
BEGIN;
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (150, 'Gavin Powell', 'gavin.powell@hotmail.com', '3 Croftlands Drive,  Ravenglass, CA18 1SJ', 'MC', '10/27', '5343193713453330');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (151, 'Caroline Robertson', 'caroline.robertson@hotmail.com', '15 Burgess Avenue,  Stanford-Le-Hope, SS17 0AU', 'A', '03/27', '2413912291247420');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (152, 'Alan Slater', 'alan.slater@hotmail.com', '3 Blackberry Close,  Burghfield Common, RG7 3EY', 'V', '02/28', '2308079158575160');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (153, 'Joe Short', 'joe.short@hotmail.com', 'Brambles,  First Avenue,  Stanford-Le-Hope, SS17 8AD', 'MC', '01/26', '5400765560501470');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (154, 'Dylan Churchill', 'dylan.churchill@hotmail.com', '219 Erith Road,  Bexleyheath, DA7 6HZ', 'A', '09/25', '2657936897460090');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (155, 'Rachel Simpson', 'rachel.simpson@hotmail.com', '36 Fenwick Street,  Pontygwaith, CF43 3LW', 'V', '07/25', '5366779950404510');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (156, 'Karen Quinn', 'karen.quinn@hotmail.com', '3 Alpine Gardens,  Bath, BA1 5PB', 'MC', '05/26', '5313639803261620');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (157, 'Nicholas Henderson', 'nicholas.henderson@hotmail.com', '2 Stonewell Grove,  Congresbury, BS49 5DR', 'A', '04/27', '2720001995048100');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (158, 'Samantha Springer', 'samantha.springer@hotmail.com', '23 Johnson Road,  Willenhall, WV12 5LU', 'V', '03/26', '2221116986248770');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (159, 'Joe Graham', 'joe.graham@hotmail.com', '8 Beechey Close,  Birmingham, B43 7LN', 'MC', '02/28', '2661221031318930');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (160, 'Eric Bell', 'eric.bell@hotmail.com', '11 Cranberry Drive,  Washington, NE38 8LN', 'A', '03/28', '2221883922143240');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (161, 'Justin Scott', 'justin.scott@hotmail.com', '19 Ashcroft Close,  Matson, GL4 6JX', 'V', '12/27', '2381589805710270');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (162, 'Adrian Arnold', 'adrian.arnold@hotmail.com', '6 Barn Close,  Great Oakley, NN18 8HZ', 'MC', '04/27', '5492366000394530');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (163, 'Jack Gibson', 'jack.gibson@hotmail.com', 'Glascoed,  Velindre, SA41 3UU', 'A', '07/26', '2432416159841500');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (164, 'Eric Mills', 'eric.mills@hotmail.com', '13 Austerberry Way,  Gosport, PO13 0BY', 'V', '03/26', '5169287229311540');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (165, 'Adrian Marshall', 'adrian.marshall@hotmail.com', '9 North Bank,  Belford, NE70 7LY', 'MC', '04/28', '2371261171060220');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (166, 'Joan Peters', 'joan.peters@hotmail.com', 'The Steading,  Grass Wood Lane,  Grassington, BD23 5DF', 'A', '11/25', '5319488211508760');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (167, 'Carl Hughes', 'carl.hughes@hotmail.com', '94 Sandbeck Avenue,  Skegness, PE25 3JX', 'V', '10/26', '5354784594663110');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (168, 'Madeleine Hemmings', 'madeleine.hemmings@hotmail.com', '10 Bellott Street,  Manchester, M8 0PP', 'MC', '09/26', '5403104732334010');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (169, 'Jacob Piper', 'jacob.piper@hotmail.com', '10 The Wharf,  New Crane Street,  Chester, CH1 4HZ', 'A', '12/27', '2720781438212340');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (170, 'Donna Kelly', 'donna.kelly@hotmail.com', '7 Tamar View,  Milton Abbot, PL19 0PF', 'V', '08/26', '2221930632429460');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (171, 'Caroline Newman', 'caroline.newman@hotmail.com', 'Rose Acre,  Appleton Wiske, DL6 2AY', 'MC', '11/27', '2720360930863980');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (172, 'Brandon Jones', 'brandon.jones@hotmail.com', 'Stanford Lodge,  Ashby Road,  Stanford On Avon, NN6 6JS', 'A', '02/27', '2481325612798190');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (173, 'Simon Welch', 'simon.welch@hotmail.com', 'The Ridgeways,  The Hem, TF11 9PT', 'V', '06/25', '2423028193149390');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (174, 'Brian Clark', 'brian.clark@hotmail.com', '5 Chartley Gate Close,  Uttoxeter, ST14 8DX', 'MC', '07/25', '2647656882186570');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (175, 'Jonathan Lee', 'jonathan.lee@hotmail.com', '1 Heol Penderyst,  Trevor, LL20 7UD', 'A', '12/25', '5190945049865940');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (176, 'James Alsop', 'james.alsop@hotmail.com', '67 The Street,  Bramford, IP8 4DX', 'V', '03/28', '2490570930065520');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (177, 'Anne Allan', 'anne.allan@hotmail.com', '9 Strathay Walk,  Corby, NN17 2JA', 'MC', '02/26', '2308624818272350');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (178, 'Brandon Lawrence', 'brandon.lawrence@hotmail.com', 'Church Farm,  Newmarket Road,  Cowlinge, CB8 9QA', 'A', '05/27', '5470475900526090');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (179, 'Max Dyer', 'max.dyer@hotmail.com', 'Bod Hyfryd,  Llaneilian, LL68 9LN', 'V', '07/25', '2496914715856380');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (180, 'Victor Pullman', 'victor.pullman@hotmail.com', '6 Willowcroft Avenue,  Aspull, WN2 1QJ', 'MC', '11/27', '2516426328742970');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (181, 'Justin Payne', 'justin.payne@hotmail.com', '15 Churnet Close,  Bedford, MK41 7ST', 'A', '04/26', '2221872650425920');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (182, 'Cameron Walsh', 'cameron.walsh@hotmail.com', '25 John Street,  Holborn, WC1N 2BS', 'V', '01/27', '2579731064638470');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (183, 'Sonia Murray', 'sonia.murray@hotmail.com', '6 Ensbury Close,  Bournemouth, BH10 4HW', 'MC', '12/26', '5173778709080920');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (184, 'Christopher Burgess', 'christopher.burgess@hotmail.com', 'Tamele,  Breeze Hill,  Bangor, LL57 4LT', 'A', '01/26', '2584192871266560');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (185, 'Lillian Dowd', 'lillian.dowd@hotmail.com', '14 Eldercroft Road,  Timperley, WA15 7HT', 'V', '07/25', '2572217711876750');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (186, 'Anthony Smith', 'anthony.smith@hotmail.com', 'Flat 2,  12 The Mall,  Clifton, BS8 4DR', 'MC', '12/25', '2479986761553070');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (187, 'Ella Powell', 'ella.powell@hotmail.com', '6 Queen Street,  Aspatria, CA7 3AP', 'A', '02/26', '5155712784134500');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (188, 'Jessica Lawrence', 'jessica.lawrence@hotmail.com', '35 Moorgate Drive,  Astley, M29 7DG', 'V', '08/25', '2360317025554280');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (189, 'Angela McGrath', 'angela.mcgrath@hotmail.com', '3 Geary Court,  Geary Drive,  Brentwood, CM14 4XP', 'MC', '09/27', '2374602271356270');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (190, 'Theresa Brown', 'theresa.brown@hotmail.com', '53 Waveney Avenue,  London, SE15 3UQ', 'A', '07/26', '5339348525204380');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (191, 'Andrea Allan', 'andrea.allan@hotmail.com', 'Old Barn,  Talybont Farm,  Llawhaden, SA67 8HJ', 'V', '02/27', '2221094892689610');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (192, 'Max Terry', 'max.terry@hotmail.com', '35 Redlands Close,  Pencoed, CF35 6YU', 'MC', '07/25', '2647656882186570');
INSERT INTO hotelbooking.customer (c_no, c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno) VALUES (193, 'Andy Lamb', 'andy.lamb@hotmail.com', '22 Redford Street, Derby, DE22 3BD', 'A', '11/26', '5362146264732480');

COMMIT;


-- Always INSERT booking first but always ensure that the b_cost is ZERO as this is calculated by the trigger when the room is assigned to the booking.
-- Always DELETE or TRUNCATE booking last to avoid foreign key conflicts.
-- booking insert - batch 1 ADD ZERO TO ALL B_COST VALUES AS THIS IS CALCULATED BY THE TRIGGER WHEN THE ROOM IS INSERTED
BEGIN;

INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (100, 50, 0, 496, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (101, 51, 0, 0, 'Paid', 154, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (102, 52, 0, 0, 'Paid', 62, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (103, 53, 0, 539, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (104, 54, 0, 434, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (105, 55, 0, 434, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (106, 56, 0, 0, 'Paid', 77, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (107, 57, 0, 455, 'Checked out', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (108, 58, 0, 0, 'Paid', 65, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (109, 59, 0, 231, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (110, 60, 0, 455, 'Checked out', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (111, 61, 0, 539, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (112, 62, 0, 455, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (113, 63, 0, 0, 'Paid', 75, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (114, 64, 0, 455, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (115, 65, 0, 0, 'Paid', 325, TRUE, '2025-11-15', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (116, 66, 0, 0, 'Paid', 325, TRUE, '2025-11-15', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (117, 67, 0, 0, 'Paid', 325, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (118, 68, 0, 0, 'Paid', 325, TRUE, '2025-11-15', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (119, 69, 0, 65, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (120, 70, 0, 0, 'Paid', 372, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (121, 71, 0, 558, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (122, 72, 0, 0, 'Paid', 65, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (123, 73, 0, 0, 'Paid', 75, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (124, 74, 0, 248, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (125, 75, 0, 260, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (126, 76, 0, 462, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (127, 77, 0, 62, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (128, 78, 0, 0, 'Paid', 75, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (129, 79, 0, 0, 'Paid', 77, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (130, 80, 0, 0, 'Paid', 77, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (131, 81, 0, 0, 'Paid', 154, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (132, 82, 0, 0, 'Paid', 154, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (133, 83, 0, 65, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (134, 84, 0, 0, 'Paid', 77, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (135, 85, 0, 62, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (136, 86, 0, 525, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (137, 87, 0, 231, 'Due to Checkout', 0, FALSE, NULL, 'demo');

COMMIT;

-- booking insert - batch 2
BEGIN;

INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (138, 88, 0, 0, 'Paid', 75, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (139, 89, 0, 152, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (140, 90, 0, 642, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (141, 91, 0, 217, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (142, 92, 0, 195, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (143, 93, 0, 0, 'Paid', 231, TRUE, '2025-11-14', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (144, 94, 0, 462, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (145, 95, 0, 417, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (146, 96, 0, 636, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (147, 97, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (148, 98, 0, 0, 'Paid', 186, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (149, 99, 0, 0, 'Paid', 411, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (150, 100, 0, 0, 'Paid', 225, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (151, 101, 0, 456, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (152, 102, 0, 612, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (153, 103, 0, 0, 'Paid', 186, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (154, 104, 0, 0, 'Paid', 231, TRUE, '2025-11-14', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (155, 105, 0, 612, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (156, 106, 0, 195, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (157, 107, 0, 372, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (158, 108, 0, 0, 'Paid', 154, TRUE, '2025-11-14', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (159, 109, 0, 195, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (160, 110, 0, 195, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (161, 111, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (162, 112, 0, 0, 'Paid', 225, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (163, 113, 0, 0, 'Paid', 75, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (164, 114, 0, 0, 'Paid', 77, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (165, 115, 0, 0, 'Paid', 77, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (166, 116, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (167, 117, 0, 420, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (168, 118, 0, 651, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (169, 119, 0, 381, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (170, 120, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (171, 121, 0, 195, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (172, 122, 0, 231, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (173, 123, 0, 687, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (174, 124, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (175, 125, 0, 0, 'Paid', 225, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (176, 126, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (177, 127, 0, 0, 'Paid', 231, TRUE, '2025-11-14', 'demo');

COMMIT;

-- booking insert - batch 3
BEGIN;

INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (178, 128, 0, 417, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (179, 129, 0, 612, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (180, 130, 0, 411, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (181, 131, 0, 426, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (182, 132, 0, 195, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (183, 133, 0, 231, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (184, 134, 0, 0, 'Paid', 225, TRUE, '2025-11-13', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (185, 135, 0, 0, 'Paid', 186, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (186, 136, 0, 420, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (187, 137, 0, 651, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (188, 138, 0, 642, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (189, 139, 0, 456, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (190, 140, 0, 426, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (191, 141, 0, 456, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (192, 142, 0, 456, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (193, 143, 0, 231, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (194, 144, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (195, 145, 0, 231, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (196, 146, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (197, 147, 0, 0, 'Paid', 75, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (198, 148, 0, 420, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (199, 149, 0, 231, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (200, 150, 0, 456, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (201, 151, 0, 225, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (202, 152, 0, 636, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (203, 153, 0, 450, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (204, 154, 0, 0, 'Paid', 75, TRUE, '2025-11-12', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (205, 155, 0, 411, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (206, 156, 0, 411, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (207, 157, 0, 231, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (208, 158, 0, 612, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (209, 159, 0, 576, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (210, 160, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (211, 161, 0, 462, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (212, 162, 0, 456, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (213, 163, 0, 186, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (214, 164, 0, 0, 'Paid', 225, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (215, 165, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (216, 166, 0, 381, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (217, 167, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');

COMMIT;

-- booking insert - batch 4
BEGIN;

INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (218, 168, 0, 597, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (219, 169, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (220, 170, 0, 195, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (221, 171, 0, 0, 'Paid', 225, TRUE, '2025-11-16', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (222, 172, 0, 411, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (223, 173, 0, 0, 'Paid', 154, TRUE, '2025-11-14', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (224, 174, 0, 231, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (225, 175, 0, 411, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (226, 176, 0, 411, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (227, 177, 0, 0, 'Paid', 75, TRUE, '2025-11-11', 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (228, 178, 0, 603, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (229, 179, 0, 648, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (230, 180, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (231, 181, 0, 231, 'Due to Checkout', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (232, 182, 0, 225, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (233, 183, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (234, 184, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (235, 185, 0, 225, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (236, 186, 0, 606, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (237, 187, 0, 426, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (238, 188, 0, 186, 'Remain Occupied', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (239, 189, 0, 231, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (240, 190, 0, 186, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (241, 191, 0, 417, 'Future Booking', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (242, 192, 0, 248, 'Checkin today', 0, FALSE, NULL, 'demo');
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes, b_payment, b_paid, payment_date, data_origin) VALUES (243, 193, 0, 124, 'Checkin today', 0, FALSE, NULL, 'demo');

COMMIT;

-- roombooking insert - batch 1
BEGIN;

INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (101, 101, '2025-11-10', '2025-11-12', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 103, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 183, '2025-11-17', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (103, 118, '2025-11-10', '2025-11-15', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (103, 159, '2025-11-15', '2025-11-18', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (103, 161, '2025-11-18', '2025-11-21', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 107, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 171, '2025-11-17', '2025-11-20', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 119, '2025-11-20', '2025-11-21', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 194, '2025-11-21', '2025-11-24', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 133, '2025-11-24', '2025-11-25', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 174, '2025-11-25', '2025-11-28', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 108, '2025-11-10', '2025-11-11', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 117, '2025-11-11', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 160, '2025-11-16', '2025-11-19', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 170, '2025-11-19', '2025-11-22', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 100, '2025-11-10', '2025-11-18', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 124, '2025-11-18', '2025-11-22', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 135, '2025-11-22', '2025-11-23', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 240, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 102, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 121, '2025-11-11', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 219, '2025-11-20', '2025-11-23', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 217, '2025-11-23', '2025-11-26', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 104, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 243, '2025-11-17', '2025-11-19', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 127, '2025-11-19', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 234, '2025-11-20', '2025-11-23', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 106, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 143, '2025-11-11', '2025-11-14', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 195, '2025-11-14', '2025-11-17', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 199, '2025-11-17', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 207, '2025-11-20', '2025-11-23', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 130, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 154, '2025-11-11', '2025-11-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 126, '2025-11-14', '2025-11-20', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 193, '2025-11-20', '2025-11-23', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 109, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 129, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 111, '2025-11-11', '2025-11-18', 2, 'demo');

COMMIT;



-- roombooking insert - batch 2
BEGIN;

INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 172, '2025-11-18', '2025-11-21', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 105, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 242, '2025-11-17', '2025-11-21', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 147, '2025-11-21', '2025-11-24', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 176, '2025-11-24', '2025-11-27', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 196, '2025-11-27', '2025-11-30', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 210, '2025-11-30', '2025-12-03', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 230, '2025-12-03', '2025-12-06', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 148, '2025-11-10', '2025-11-13', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 120, '2025-11-10', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 213, '2025-11-16', '2025-11-19', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 215, '2025-11-19', '2025-11-22', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 233, '2025-11-22', '2025-11-25', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 153, '2025-11-10', '2025-11-13', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 185, '2025-11-13', '2025-11-16', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 238, '2025-11-16', '2025-11-19', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 175, '2025-11-10', '2025-11-13', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 221, '2025-11-13', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 235, '2025-11-16', '2025-11-19', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (209, 184, '2025-11-10', '2025-11-13', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (209, 214, '2025-11-13', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 150, '2025-11-10', '2025-11-13', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 162, '2025-11-13', '2025-11-16', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 201, '2025-11-16', '2025-11-19', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 232, '2025-11-19', '2025-11-22', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (211, 110, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (211, 182, '2025-11-17', '2025-11-20', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (211, 112, '2025-11-20', '2025-11-27', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 122, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 114, '2025-11-11', '2025-11-18', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 125, '2025-11-18', '2025-11-22', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 115, '2025-11-10', '2025-11-15', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 156, '2025-11-15', '2025-11-18', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 166, '2025-11-18', '2025-11-21', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 220, '2025-11-21', '2025-11-24', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (302, 116, '2025-11-10', '2025-11-15', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (302, 142, '2025-11-15', '2025-11-18', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 131, '2025-11-10', '2025-11-12', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 223, '2025-11-12', '2025-11-14', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 231, '2025-11-14', '2025-11-17', 2, 'demo');

COMMIT;


-- roombooking insert - batch 3
BEGIN;

INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (304, 132, '2025-11-10', '2025-11-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (304, 158, '2025-11-12', '2025-11-14', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (304, 224, '2025-11-14', '2025-11-17', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 134, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 177, '2025-11-11', '2025-11-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 137, '2025-11-14', '2025-11-17', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 239, '2025-11-17', '2025-11-20', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (306, 164, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (306, 165, '2025-11-11', '2025-11-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 163, '2025-11-10', '2025-11-11', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 197, '2025-11-11', '2025-11-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 128, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 113, '2025-11-11', '2025-11-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 138, '2025-11-12', '2025-11-13', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (310, 123, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (310, 204, '2025-11-11', '2025-11-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (311, 227, '2025-11-10', '2025-11-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (312, 136, '2025-11-10', '2025-11-17', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 139, '2025-11-20', '2025-11-21', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 139, '2025-11-20', '2025-11-21', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 140, '2025-12-06', '2025-12-09', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 140, '2025-12-06', '2025-12-09', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 140, '2025-12-06', '2025-12-09', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 141, '2025-11-28', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 141, '2025-11-28', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 141, '2025-11-28', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 144, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (304, 144, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 145, '2025-11-20', '2025-11-23', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 145, '2025-11-20', '2025-11-23', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 146, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 146, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (209, 146, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 149, '2025-11-13', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 149, '2025-11-13', '2025-11-16', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 151, '2025-11-17', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 151, '2025-11-17', '2025-11-20', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (103, 152, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 152, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 152, '2025-11-26', '2025-11-29', 1, 'demo');

COMMIT;


-- roombooking insert - batch 4
BEGIN;

INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (103, 155, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 155, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 155, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 157, '2025-11-23', '2025-11-26', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 157, '2025-11-23', '2025-11-26', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 167, '2025-11-22', '2025-11-25', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (307, 167, '2025-11-22', '2025-11-25', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (101, 168, '2025-11-18', '2025-11-21', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (302, 168, '2025-11-18', '2025-11-21', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (311, 168, '2025-11-18', '2025-11-21', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 169, '2025-11-29', '2025-12-02', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 169, '2025-11-29', '2025-12-02', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 173, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 173, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (306, 173, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 178, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 178, '2025-11-26', '2025-11-29', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 179, '2025-11-26', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 179, '2025-11-26', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 179, '2025-11-26', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 180, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 180, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 181, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 181, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (105, 186, '2025-12-02', '2025-12-05', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 186, '2025-12-02', '2025-12-05', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 187, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 187, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 187, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 188, '2025-12-09', '2025-12-12', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 188, '2025-12-09', '2025-12-12', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 188, '2025-12-09', '2025-12-12', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (101, 189, '2025-11-21', '2025-11-24', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 189, '2025-11-21', '2025-11-24', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 190, '2025-11-24', '2025-11-27', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 190, '2025-11-24', '2025-11-27', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (102, 191, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (311, 191, '2025-11-23', '2025-11-26', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 192, '2025-11-26', '2025-11-29', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (311, 192, '2025-11-26', '2025-11-29', 2, 'demo');

COMMIT;


-- roombooking insert - batch 5
BEGIN;

INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (212, 198, '2025-11-25', '2025-11-28', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 198, '2025-11-25', '2025-11-28', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (201, 200, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (209, 200, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 202, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (210, 202, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 202, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 203, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 203, '2025-11-29', '2025-12-02', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 205, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (208, 205, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 206, '2025-11-16', '2025-11-19', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (307, 206, '2025-11-16', '2025-11-19', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (106, 208, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 208, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (303, 208, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (107, 209, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (211, 209, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 209, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 211, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (304, 211, '2025-12-02', '2025-12-05', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 212, '2025-12-09', '2025-12-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (309, 212, '2025-12-09', '2025-12-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (104, 216, '2025-12-08', '2025-12-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 216, '2025-12-08', '2025-12-11', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (205, 218, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 218, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (310, 218, '2025-12-05', '2025-12-08', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 222, '2025-12-11', '2025-12-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (307, 222, '2025-12-11', '2025-12-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 225, '2025-12-11', '2025-12-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (308, 225, '2025-12-11', '2025-12-14', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 226, '2025-12-14', '2025-12-17', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (307, 226, '2025-12-14', '2025-12-17', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 228, '2025-12-09', '2025-12-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (204, 228, '2025-12-09', '2025-12-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (306, 228, '2025-12-09', '2025-12-12', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (101, 229, '2025-12-02', '2025-12-05', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (206, 229, '2025-12-02', '2025-12-05', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (305, 229, '2025-12-02', '2025-12-05', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (207, 236, '2025-12-08', '2025-12-11', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (301, 236, '2025-12-08', '2025-12-11', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (311, 236, '2025-12-08', '2025-12-11', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (202, 237, '2025-12-05', '2025-12-08', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (302, 237, '2025-12-05', '2025-12-08', 1, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (108, 241, '2025-12-12', '2025-12-15', 2, 'demo');
INSERT INTO hotelbooking.roombooking (r_no, b_ref, checkin, checkout, guests, data_origin) VALUES (203, 241, '2025-12-12', '2025-12-15', 2, 'demo');


COMMIT;




-- Update outstanding amounts in booking table (incorrect in INSERT)
UPDATE hotelbooking.booking
SET b_outstanding = b_cost
WHERE b_paid = false;


SELECT * FROM hotelbooking.booking;