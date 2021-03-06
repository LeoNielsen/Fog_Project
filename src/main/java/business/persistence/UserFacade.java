package business.persistence;

import business.entities.User;
import business.exceptions.UserException;

import java.util.ArrayList;

public class UserFacade
{
    UserMapper userMapper;

    public UserFacade(Database database)
    {
        userMapper = new UserMapper(database);
    }

    public User login(String email, String password) throws UserException
    {
        return userMapper.login(email, password);
    }

    public User createUser(String email, String password, String firstname, String lastname, String streetname, String houseNr, String zipcode, String phoneNr) throws UserException
    {
        User user = new User(email, password, "customer",firstname, lastname, streetname, houseNr, zipcode, phoneNr);
        userMapper.createUser(user);
        return user;
    }

    public ArrayList<User> getAllUsers() throws UserException
    {
        return userMapper.getAllUsers();
    }


    public void updateUser(User user) {
        userMapper.updateUser(user);
    }
}
