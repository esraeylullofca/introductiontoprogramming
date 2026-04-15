// Prompt the user for a non-negative number of cents
int get_cents(void)
{
    int cents;

    // Re-prompt until a valid non-negative value is entered
    do
    {
        cents = get_int("Change owed: ");
    }
    while (cents < 0);

    return cents;
}

// Return how many quarters fit in `cents`
int calculate_quarters(int cents)
{
    return cents / 25;
}

// Return how many dimes fit in `cents`
int calculate_dimes(int cents)
{
    return cents / 10;
}

// Return how many nickels fit in `cents`
int calculate_nickels(int cents)
{
    return cents / 5;
}

// Return how many pennies fit in `cents`
int calculate_pennies(int cents)
{
    return cents;
}
