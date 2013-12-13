drop database if exists adxpress;
create database adxpress;
use adxpress;
drop table if exists categories;
drop table if exists members;
drop table if exists ads;
drop table if exists pages;
drop table if exists items;
drop table if exists links_categories;
drop table if exists links;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS priorities;
create table categories
(
  category_id integer auto_increment primary key,
  name varchar(50),
  par_category_id integer
);

insert into categories (name, par_category_id) values ('Announcements', null);
insert into categories (name, par_category_id) values ('Autos & Motorcycles', null);
insert into categories (name, par_category_id) values ('Business Opportunities', null);
insert into categories (name, par_category_id) values ('Computers & Software', null);
insert into categories (name, par_category_id) values ('Employment', null);
insert into categories (name, par_category_id) values ('Services', null);
insert into categories (name, par_category_id) values ('Pets & Animals', null);
insert into categories (name, par_category_id) values ('Anniversaries', 1);
insert into categories (name, par_category_id) values ('Auctions', 1);
insert into categories (name, par_category_id) values ('Births', 1);
insert into categories (name, par_category_id) values ('Bookgroups', 1);
insert into categories (name, par_category_id) values ('Bris/Christenings', 1);
insert into categories (name, par_category_id) values ('Coupons', 1);
insert into categories (name, par_category_id) values ('Promotion', 1);
insert into categories (name, par_category_id) values ('Clubs/Organization', 1);
insert into categories (name, par_category_id) values ('Car', 2);
insert into categories (name, par_category_id) values ('Motorcycle', 2);
insert into categories (name, par_category_id) values ('Truck', 2);
insert into categories (name, par_category_id) values ('Van', 2);
insert into categories (name, par_category_id) values ('Sport Utility and Jeeps', 2);
insert into categories (name, par_category_id) values ('Casinos', 3);
insert into categories (name, par_category_id) values ('Apparel', 3);
insert into categories (name, par_category_id) values ('Computers and Internet', 3);
insert into categories (name, par_category_id) values ('Food and Beverage', 3);
insert into categories (name, par_category_id) values ('Marketing', 3);
insert into categories (name, par_category_id) values ('Travel and Transportation', 3);
insert into categories (name, par_category_id) values ('Telecommunications', 3);
insert into categories (name, par_category_id) values ('Legal Services', 6);
insert into categories (name, par_category_id) values ('Home & Garden', 6);
insert into categories (name, par_category_id) values ('Entertainment and Arts', 6);
insert into categories (name, par_category_id) values ('Administrative and Corporate', 5);
insert into categories (name, par_category_id) values ('Media, Arts, and Design', 5);
insert into categories (name, par_category_id) values ('Facilities Management and Maintenance', 5);
insert into categories (name, par_category_id) values ('Financial Services', 5);
insert into categories (name, par_category_id) values ('Health Care', 5);
insert into categories (name, par_category_id) values ('Information Technology', 5);
insert into categories (name, par_category_id) values ('Engineering', 5);
insert into categories (name, par_category_id) values ('Dogs', 7);
insert into categories (name, par_category_id) values ('Cats', 7);
insert into categories (name, par_category_id) values ('Fish and Aquariums', 7);
insert into categories (name, par_category_id) values ('Miscellaneous Supplies', 7);
insert into categories (name, par_category_id) values ('Reptiles', 7);
insert into categories (name, par_category_id) values ('Domain Names', 4);
insert into categories (name, par_category_id) values ('Hardware', 4);
insert into categories (name, par_category_id) values ('Software', 4);
insert into categories (name, par_category_id) values ('Networking', 4);

create table members
(
  member_id integer auto_increment primary key,
  member_login varchar(20) not null,
  member_password varchar(20) not null,
  member_level integer not null default 1,
  name varchar(50) not null,
  email varchar(50) not null,
  home_phone varchar(50),
  work_phone varchar(50),
  location varchar(255)
);

insert into members (member_login, member_password, member_level, name, email)
	values ('admin', 'admin', 3, 'Administrator', 'admin@classifieds.com');


create table ads
(
  ad_id integer auto_increment primary key,
  member_id integer not null,
  category_id integer not null,
  name varchar(100) not null,
  ad_description text,
  date_posted datetime,
  price decimal(10,4)
);

insert into ads (member_id, category_id, name, ad_description, date_posted, price)
	values (1, 23, 'Develop Classifieds Web Site', null, '2008-03-02', 10000);
CREATE TABLE pages (
       category_id          int auto_increment primary key,
       name                 varchar(50) NULL,
       par_category_id      int NULL
);

insert into pages (name, par_category_id) values ('Automotive', null);
insert into pages (name, par_category_id) values ('Community', null);
insert into pages (name, par_category_id) values ('Computers and Internet', null);
insert into pages (name, par_category_id) values ('Education and Instruction', null);
insert into pages (name, par_category_id) values ('Entertainment and Arts', null);
insert into pages (name, par_category_id) values ('Food and Dining', null);
insert into pages (name, par_category_id) values ('Health and Medicine', null);
insert into pages (name, par_category_id) values ('Home and Garden', null);
insert into pages (name, par_category_id) values ('Legal and Financial', null);
insert into pages (name, par_category_id) values ('Accessories', 1);
insert into pages (name, par_category_id) values ('Auto Wrecking', 1);
insert into pages (name, par_category_id) values ('Dealers', 1);
insert into pages (name, par_category_id) values ('Motorcycles', 1);
insert into pages (name, par_category_id) values ('Racing', 1);
insert into pages (name, par_category_id) values ('Rental', 1);
insert into pages (name, par_category_id) values ('Tires', 1);
insert into pages (name, par_category_id) values ('Animal and Humane Societies', 2);
insert into pages (name, par_category_id) values ('Children and Youth', 2);
insert into pages (name, par_category_id) values ('Disabilities', 2);
insert into pages (name, par_category_id) values ('Government', 2);
insert into pages (name, par_category_id) values ('Housing', 2);
insert into pages (name, par_category_id) values ('Libraries', 2);
insert into pages (name, par_category_id) values ('Post Offices', 2);
insert into pages (name, par_category_id) values ('Religion', 2);
insert into pages (name, par_category_id) values ('Communications and Networking', 3);
insert into pages (name, par_category_id) values ('Computer Graphics', 3);
insert into pages (name, par_category_id) values ('Computer Rental', 3);
insert into pages (name, par_category_id) values ('Computer Service and Repair', 3);
insert into pages (name, par_category_id) values ('Computer Training', 3);
insert into pages (name, par_category_id) values ('Desktop Publishing', 3);
insert into pages (name, par_category_id) values ('Software', 3);
insert into pages (name, par_category_id) values ('Colleges and Universities', 4);
insert into pages (name, par_category_id) values ('K-12', 4);
insert into pages (name, par_category_id) values ('Language', 4);
insert into pages (name, par_category_id) values ('Preschools', 4);
insert into pages (name, par_category_id) values ('Tutoring', 4);
insert into pages (name, par_category_id) values ('Bars, Pubs, and Clubs', 5);
insert into pages (name, par_category_id) values ('Dance', 5);
insert into pages (name, par_category_id) values ('Entertainers', 5);
insert into pages (name, par_category_id) values ('Movies and Film', 5);
insert into pages (name, par_category_id) values ('Museums and Galleries', 5);
insert into pages (name, par_category_id) values ('Music', 5);
insert into pages (name, par_category_id) values ('Tickets', 5);
insert into pages (name, par_category_id) values ('Video', 5);
insert into pages (name, par_category_id) values ('Beverages', 6);
insert into pages (name, par_category_id) values ('Candy and Sweets', 6);
insert into pages (name, par_category_id) values ('Catering', 6);
insert into pages (name, par_category_id) values ('Culinary Schools and Classes', 6);
insert into pages (name, par_category_id) values ('Grocery Stores', 6);
insert into pages (name, par_category_id) values ('Meat', 6);
insert into pages (name, par_category_id) values ('Natural and Organic', 6);
insert into pages (name, par_category_id) values ('Poultry', 6);
insert into pages (name, par_category_id) values ('Restaurants', 6);
insert into pages (name, par_category_id) values ('Alternative Medicine', 7);
insert into pages (name, par_category_id) values ('Care Providers', 7);
insert into pages (name, par_category_id) values ('Doctors and Clinics', 7);
insert into pages (name, par_category_id) values ('Education', 7);
insert into pages (name, par_category_id) values ('Fitness', 7);
insert into pages (name, par_category_id) values ('Mental Health', 7);
insert into pages (name, par_category_id) values ('Pharmacies', 7);
insert into pages (name, par_category_id) values ('Appliances', 8);
insert into pages (name, par_category_id) values ('Bed and Bath', 8);
insert into pages (name, par_category_id) values ('Carpets and Rugs', 8);
insert into pages (name, par_category_id) values ('Cleaning Services', 8);
insert into pages (name, par_category_id) values ('Furniture', 8);
insert into pages (name, par_category_id) values ('Housewares', 8);
insert into pages (name, par_category_id) values ('Lawn and Garden', 8);
insert into pages (name, par_category_id) values ('Linens', 8);
insert into pages (name, par_category_id) values ('Accounting and Bookkeeping', 9);
insert into pages (name, par_category_id) values ('Arbitration and Mediation', 9);
insert into pages (name, par_category_id) values ('Bail Bonds', 9);
insert into pages (name, par_category_id) values ('Bankruptcy', 9);
insert into pages (name, par_category_id) values ('Banks', 9);
insert into pages (name, par_category_id) values ('Court Reporting Services', 9);
insert into pages (name, par_category_id) values ('Credit Services', 9);
insert into pages (name, par_category_id) values ('Financing', 9);
insert into pages (name, par_category_id) values ('Insurance', 9);
insert into pages (name, par_category_id) values ('Law Firms', 9);
insert into pages (name, par_category_id) values ('Taxes', 9);

CREATE TABLE items (
       item_id              int auto_increment primary key,
       name                 varchar(100) NULL,
       address              varchar(255) NULL,
       city                 varchar(50) NULL,
       phone                varchar(50) NULL,
       state                varchar(2) NULL,
       zip                  varchar(10) NULL,
       category_id          int NULL,
       notes                text NULL,
       email                varchar(50) NULL,
       url                  varchar(50) NULL
);

insert into items (name, address, city, phone, state, zip, category_id, url)
  values ('MySQL', '2226 A Westborough Blvd. #405', 'San Francisco', '', 'CA', '94080', 31, 'http://www.mysql.com');
insert into items (name, address, city, phone, state, zip, category_id, url)
  values ('IBM', '325 Corey Way # 105', 'San Francisco', '(650) 589-5500', 'CA', '94080', '31', 'http://www.ibm.com');
insert into items (name, address, city, phone, state, zip, category_id, url)
  values ('Oracle', '500 Oracle Pkwy', 'Redwood City', '(650) 506-7000', 'CA', '94065', '31', 'http://www.oracle.com');
insert into items (name, address, city, phone, state, zip, category_id, url)
  values ('Microsoft', '185 Berry St # 6600', 'San Francisco', '(415) 817-0200', 'CA', '94107', '31', 'http://www.microsoft.com');
insert into items (name, address, city, phone, state, zip, category_id, url)
  values ('Sun Microsystems', '100 California St # 800', 'San Francisco', '(415) 781-8140', 'CA', '94111', '31', 'http://www.sun.com');
create table links_categories
(
	category_id integer auto_increment primary key,
	category_desc varchar(50) not null,
	parent_category_id integer
);

insert into links_categories (category_desc) values ('Computers & Internet');
insert into links_categories (category_desc) values ('Business & Economy');
insert into links_categories (category_desc) values ('Entertainment');
insert into links_categories (category_desc) values ('Science');

create table links
(
	link_id integer auto_increment primary key,
	name varchar(100) not null,
	category_id integer,
	url varchar(100) not null,
	description text,
	approved integer not null default 0,
	add_date datetime
);

insert into links (name, category_id, url, description, approved,add_date)
	VALUES ('Charge',1,'http://www.mysql.com','Revolutionizing the way you code...',1,'2001-01-01');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('Yahoo',2,'http://www.yahoo.com','World\'s largest Online Portal',1,'2008-03-02');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('Nickelodeon',3,'http://www.nick.com','Entertainment for kids',1,'2008-03-02');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('eBay',2,'http://www.ebay.com','Online Auctions',1,'2008-03-02');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('Discovery.com',4,'http://www.discovery.com','Disover something new every day',1,'2008-03-02');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('Xmas Fred',3,'http://www.ohaha.com/xmasfred','World\'s funniest character',1,'2008-03-02');
insert into links (name, category_id, url, description, approved,add_date)
  VALUES ('Amazon.com',2,'http://www.amazon.com','World\'s largest online store',1,'2008-03-02');
CREATE TABLE priorities (
       priority_id          int auto_increment PRIMARY KEY,
       priority_desc        varchar(15) NULL
);

insert into priorities (priority_desc) values ('Highest');
insert into priorities (priority_desc) values ('High');
insert into priorities (priority_desc) values ('Normal');
insert into priorities (priority_desc) values ('Low');
insert into priorities (priority_desc) values ('Lowest');

CREATE TABLE projects (
       project_id           int auto_increment PRIMARY KEY,
       project_name         varchar(50) NULL,
       employee_id          int
);

insert into projects (project_name, employee_id) values ('IBM', 1);

CREATE TABLE statuses (
       status_id            int auto_increment PRIMARY KEY,
       status               varchar(15) NULL
);

insert into statuses (status) values ('Open');
insert into statuses (status) values ('On hold');
insert into statuses (status) values ('Closed');
insert into statuses (status) values ('In progress');

CREATE TABLE tasks (
       task_id              int auto_increment PRIMARY KEY,
       project_id           int NOT NULL,
       priority_id          int NOT NULL,
       status_id            int NOT NULL,
       task_name            varchar(100) NULL,
       task_desc            text NULL,
       resolution           text NULL,
       assigned_by          int NULL DEFAULT 0,
       assigned_to          int NOT NULL,
       date_assigned        datetime NULL,
       date_resolved        datetime NULL
);