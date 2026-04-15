bool vote(string name)
{
    // Loop through all candidates
    for (int i = 0; i < candidate_count; i++)
    {
        // Case-insensitive comparison
        if (strcasecmp(candidates[i].name, name) == 0)
        {
            candidates[i].votes++;
            return true;
        }
    }

    // No match found
    return false;
}
