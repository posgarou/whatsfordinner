# Recipe Concierge

## Client

### Time of Day

#### DEFAULT TIME BEHAVIOR

As a client user, by default I should see recipes depending on the current time of day.

**Time**: 0 min (server data default)

#### USER CHOICE OF TIME

As a client user, I should have the option to select recipes for a different meal.

**Time**: 45 min (for client side)

### RECIPE SELECTION

As a client user, I should see a list of 3 recipes of the appropriate set while using the concierge service.

**DETAILS**: This will be random for the MVP but will use a much more sophisticated algorithm later.

#### VIEW

**Time**: 1 hour

#### CONTROLLER

**Time**: 1 hour

## Server

### Time of Day

#### DEFAULT

When no parameters are received, the returned recipes should depend on the time of day.

**Time**: 45 min

#### USER SPECS

When a specific meal is received as a parameter, the recipes shown should suit that meal.

**Time**: 1 hour