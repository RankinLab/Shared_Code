def convert_to_celsius(fahrenheit):
    """(number)-> float
    Return the number of celsius degrees equivalent to fahrenheit degrees.

    >>>convert_to_celsius(75)
    23.8888888889
    """

    return (fahrenheit - 32.0) * 5.0 / 9.0

def above_freezing(celsius):
    """ (number)-> bool

    Return True iff temperature celsius degrees is above freezing.

    >>>above_freezing(5.2)
    True
    >>>above_freezing(-2)
    False
    """

    return celsius > 0


if __name__ == '__main__' :
    fahrenheit = float(input('Enter the temp in fahrenheit: '))
    celsius = convert_to_celsius(fahrenheit)
    if above_freezing(celsius):
        print('it is above freezing')
    else:
        print('it is below freezing')


    
