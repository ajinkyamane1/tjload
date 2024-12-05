def extract_suites():

    #   Call Properties File
    #   Combine All Suites into Variable
    #   return variable into BAT File
    file = open("SuiteNames.txt", "r")
    content = file.readlines()
    var = [i.split('\n', 1)[0] for i in content]
    list_length=len(var)
    suites=""
    for i in range(list_length):
        suites=+suites+f" ../TestCases/"+var[i]
    print(suites)
    file.close()

    return suites

if __name__ == '__main__':
    notifier = extract_suites()