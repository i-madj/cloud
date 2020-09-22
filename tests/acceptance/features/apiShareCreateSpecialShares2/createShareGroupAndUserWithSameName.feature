@api @files_sharing-app-required @toImplementOnOCIS @issue-ocis-reva-34 @issue-ocis-reva-243
Feature: sharing works when a username and group name are the same

  Background:
    Given the administrator has set the default folder for received shares to "Shares"
    And auto-accept shares has been disabled
    And user "Alice" has been created with default attributes and skeleton files

  @skipOnLDAP @skipOnOcV10.3.0 @skipOnOcV10.3.1
  Scenario: creating a new share with user and a group having same name
    Given these users have been created without skeleton files:
      | username |
      | Brian    |
      | Carol    |
    And group "Brian" has been created
    And user "Carol" has been added to group "Brian"
    And user "Alice" has uploaded file with content "Random data" to "/randomfile.txt"
    And user "Alice" has shared file "randomfile.txt" with group "Brian"
    And user "Carol" has accepted share "/randomfile.txt" offered by user "Alice"
    When user "Alice" shares file "randomfile.txt" with user "Brian" using the sharing API
    And user "Brian" accepts share "/randomfile.txt" offered by user "Alice" using the sharing API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And user "Brian" should see the following elements
      | /Shares/randomfile.txt |
    And user "Carol" should see the following elements
      | /Shares/randomfile.txt |
    And the content of file "/Shares/randomfile.txt" for user "Brian" should be "Random data"
    And the content of file "/Shares/randomfile.txt" for user "Carol" should be "Random data"

  @skipOnLDAP @skipOnOcV10.3.0 @skipOnOcV10.3.1
  Scenario: creating a new share with group and a user having same name
    Given these users have been created without skeleton files:
      | username |
      | Brian    |
      | Carol    |
    And group "Brian" has been created
    And user "Carol" has been added to group "Brian"
    And user "Alice" has uploaded file with content "Random data" to "/randomfile.txt"
    And user "Alice" has shared file "randomfile.txt" with user "Brian"
    And user "Brian" has accepted share "/randomfile.txt" offered by user "Alice"
    When user "Alice" shares file "randomfile.txt" with group "Brian" using the sharing API
    And user "Carol" accepts share "/randomfile.txt" offered by user "Alice" using the sharing API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And user "Brian" should see the following elements
      | /Shares/randomfile.txt |
    And user "Carol" should see the following elements
      | /Shares/randomfile.txt |
    And the content of file "/Shares/randomfile.txt" for user "Brian" should be "Random data"
    And the content of file "/Shares/randomfile.txt" for user "Carol" should be "Random data"

  @skipOnLDAP
  Scenario: creating a new share with user and a group having same name but different case
    Given these users have been created without skeleton files:
      | username |
      | Brian    |
      | Carol    |
    And group "Brian" has been created
    And user "Carol" has been added to group "Brian"
    And user "Alice" has uploaded file with content "Random data" to "/randomfile.txt"
    And user "Alice" has shared file "randomfile.txt" with group "Brian"
    And user "Carol" has accepted share "/randomfile.txt" offered by user "Alice"
    When user "Alice" shares file "randomfile.txt" with user "Brian" using the sharing API
    And user "Brian" accepts share "/randomfile.txt" offered by user "Alice" using the sharing API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And user "Brian" should see the following elements
      | /Shares/randomfile.txt |
    And user "Carol" should see the following elements
      | /Shares/randomfile.txt |
    And the content of file "/Shares/randomfile.txt" for user "Brian" should be "Random data"
    And the content of file "/Shares/randomfile.txt" for user "Carol" should be "Random data"

  @skipOnLDAP
  Scenario: creating a new share with group and a user having same name but different case
    Given these users have been created without skeleton files:
      | username |
      | Brian    |
      | Carol    |
    And group "Brian" has been created
    And user "Carol" has been added to group "Brian"
    And user "Alice" has uploaded file with content "Random data" to "/randomfile.txt"
    And user "Alice" has shared file "randomfile.txt" with user "Brian"
    And user "Brian" has accepted share "/randomfile.txt" offered by user "Alice"
    When user "Alice" shares file "randomfile.txt" with group "Brian" using the sharing API
    And user "Carol" accepts share "/randomfile.txt" offered by user "Alice" using the sharing API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And user "Carol" should see the following elements
      | /Shares/randomfile.txt |
    And user "Brian" should see the following elements
      | /Shares/randomfile.txt |
    And the content of file "/Shares/randomfile.txt" for user "Carol" should be "Random data"
    And the content of file "/Shares/randomfile.txt" for user "Brian" should be "Random data"
