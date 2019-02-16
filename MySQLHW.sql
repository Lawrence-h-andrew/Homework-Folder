"1a. Display the first and last names of all actors from the table actor."
Use sakila;
Select * From sakila.actor;
Select first_name, last_name from actor;

"1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name."
Alter Table actor
Add Column ActorName;
INSERT into actor (Actorname)
Values (first_name, last_name)

"2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
What is one query would you use to obtain this information?"
Use sakila;
Select * FROM actor where first_name = "Joe";

"2b. Find all actors whose last name contain the letters GEN:"
Use sakila;
Select * FROM actor where last_name like "%GEN%";

'2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:'
Use sakila;
Select * FROM actor
ORDER BY  last_name, first_name;
Select * FROM actor where last_name like "%LI%";

'2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:'
Use sakila;
Select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");

"3a. You want to keep a description of each actor. You dont think you will be performing queries on a description, 
so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, 
as the difference between it and VARCHAR are significant)."
Use sakila; 



"3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column."

"4a. List the last names of actors, as well as how many actors have that last name."
Use sakila; 
Select count(last_name), last_name
from actor group by last_name


"4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors"
Use sakila; 
Select count(last_name), last_name
from actor group by last_name
order by count(last_name) >= 2

"4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record."
Use sakila;
Update actor 
Set first_name = "HARPO", last_name = "WILLIAMS"
Where actor_id = 172

"4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single
 query, if the first name of the actor is currently HARPO, change it to GROUCHO."
Use sakila;
Update actor
Set first_name = "GROUCHO"
Where first_name = "HARPO"

"5a. You cannot locate the schema of the address table. Which query would you use to re-create it?"
SHOW CREATE TABLE address

"6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:"
Use sakila; 
Select staff.first_name, staff.last_name, address.address
From address
Inner Join staff on
staff.address_id=address.address_id

"6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment."
Use sakila;
Select staff.staff_id, payment.amount, payment.payment_date
from payment 
inner join staff on
staff.staff_id=payment.staff_id;
Select sum (amount) as "Staff Amount Total for August of 2005"
from staff
group by staff_id


"6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join."

"6d. How many copies of the film Hunchback Impossible exist in the inventory system?"
SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id ) AS 'Number of Copies'
FROM film;

"6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
List the customers alphabetically by last name:"


"7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
films starting with the letters K and Q have also soared in popularity. 
Use subqueries to display the titles of movies starting with the letters K and Q whose language is English."
Use sakila;
Select * from film 
where title like "K%" or title like "Q%" and language_id = 1;

"7b. Use subqueries to display all actors who appear in the film Alone Trip."
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (SELECT film_id
   FROM film
   WHERE title = 'Alone Trip')
);



"7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian 
customers. Use joins to retrieve this information. Link city and coiuntry then address then customer"
Use sakila;
SELECT customer.first_name, customer.last_name, customer.email, customer.address_id, address.address_id
from address
inner join customer on 
customer.address_id=address.address_id

"7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as family films."
Select title
from film 
where category_id
(
  SELECT film_id
  FROM film_category
  WHERE film_id IN
  (
   SELECT category_id
   FROM category
   WHERE name = 'Family'
  )
);

"7e. Display the most frequently rented movies in descending order."

7f. Write a query to display how much business, in dollars, each store brought in.

7g. Write a query to display for each store its store ID, city, and country.

7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, 
film_category, inventory, payment, and rental.)

8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create 
a view.

8b. How would you display the view that you created in 8a?

8c. You find that you no longer need the view top_five_genres. Write a query to delete it.