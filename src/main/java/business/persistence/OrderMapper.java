package business.persistence;

import business.entities.Material;
import business.entities.Order;
import business.entities.User;

import java.sql.*;
import java.util.ArrayList;

public class OrderMapper {

    private Database database;

    protected OrderMapper(Database database) {
        this.database = database;
    }

    /** insert and update in database **/

    protected void saveOrder(Order order) {
        try (Connection connection = database.connect()) {
            String sql = "INSERT INTO user_orders (user_id, totalprice, totalcost, orderdate, status, carport_length, carport_width, roof_type, roof_angle, shed_length, shed_width, remarks) " +
                    "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUser().getId());
                ps.setFloat(2, order.getTotalPrice());
                ps.setFloat(3, order.getTotalCost());
                ps.setTimestamp(4, order.getOrderDate());
                ps.setString(5, order.getStatus());
                ps.setInt(6, order.getCarportLength());
                ps.setInt(7, order.getCarportWidth());
                ps.setString(8, order.getRoofType());
                ps.setInt(9, order.getRoofAngle());
                ps.setInt(10, order.getShedLength());
                ps.setInt(11, order.getShedWidth());
                ps.setString(12, order.getRemarks());

                ps.executeUpdate();
                ResultSet ids = ps.getGeneratedKeys();
                ids.next();
                int id = ids.getInt(1);
                order.setId(id);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void updateOrder(Order order) {
        try (Connection connection = database.connect()) {

            String sql = "UPDATE user_orders SET totalprice=?, totalcost=?, orderdate=?, status=?, carport_length=?, carport_width=?, roof_type=?, roof_angle=?, shed_length=?, shed_width=? " +
                    "WHERE id_order=?";

            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setFloat(1, order.getTotalPrice());
                ps.setFloat(2, order.getTotalCost());
                ps.setTimestamp(3, order.getOrderDate());
                ps.setString(4, order.getStatus());
                ps.setInt(5, order.getCarportLength());
                ps.setInt(6, order.getCarportWidth());
                ps.setString(7, order.getRoofType());
                ps.setInt(8, order.getRoofAngle());
                ps.setInt(9, order.getShedLength());
                ps.setInt(10, order.getShedWidth());
                ps.setInt(11, order.getId());

                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void deleteOrder(Order order) {
        try (Connection connection = database.connect()) {

            String sql = "DELETE FROM user_orders WHERE id_order=?";

            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getId());
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    /** Select from database **/

    protected ArrayList<Integer> getOrderId(int user_id) {
        ArrayList<Integer> orders = new ArrayList<>();

        try (Connection connection = database.connect()) {
            String sql = "SELECT id_order FROM user_orders WHERE user_id = ? AND status != ? AND status != ? AND status != ?";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, user_id);
                ps.setString(2, "request");
                ps.setString(3, "offer");
                ps.setString(4, "rejected");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id_order");
                    orders.add(id);
                }
                return orders;
            } catch (Exception e) {
                throw new Exception("Could not find order id");
            }
        } catch (Exception throwables) {
            try {
                throw new Exception("Could not find order id");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return orders;
    }

    protected ArrayList<Integer> getOfferAndRequestId(int user_id) {
        ArrayList<Integer> orders = new ArrayList<>();

        try (Connection connection = database.connect()) {
            String sql = "SELECT id_order FROM user_orders WHERE user_id = ? AND status = ? OR user_id = ? AND status = ? OR user_id = ? AND status = ?";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, user_id);
                ps.setString(2, "request");
                ps.setInt(3, user_id);
                ps.setString(4, "offer");
                ps.setInt(5, user_id);
                ps.setString(6, "rejected");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id_order");
                    orders.add(id);
                }
                return orders;
            } catch (Exception e) {
                throw new Exception("Could not find order id");
            }
        } catch (Exception throwables) {
            try {
                throw new Exception("Could not find order id");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return orders;
    }

    protected Order getAllOrdersUser(int order_id, User user, ArrayList<Material> BOM)  {
        Order order = null;

        try (Connection connection = database.connect()) {
            String sql = "SELECT * FROM user_orders WHERE id_order = ?";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, order_id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    float totalCost = rs.getFloat("totalcost");
                    float totalPrice = rs.getFloat("totalprice");
                    Timestamp orderDate = rs.getTimestamp("orderdate");
                    String status = rs.getString("status");
                    int carportLength = rs.getInt("carport_length");
                    int carportWidth = rs.getInt("carport_width");
                    String roofType = rs.getString("roof_Type");
                    int roofAngle = rs.getInt("roof_angle");
                    int shedLength = rs.getInt("shed_length");
                    int shedWidth = rs.getInt("shed_width");
                    String remarks = rs.getString("remarks");

                    order = new Order(order_id, user, totalCost, totalPrice, orderDate, status, carportLength, carportWidth, roofType, roofAngle, shedLength, shedWidth, remarks, BOM);
                }
                return order;
            } catch (Exception e) {
                throw new Exception("Could not find order");
            }
        } catch (Exception throwables) {
            try {
                throw new Exception("Could not find order");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return order;
    }
}
