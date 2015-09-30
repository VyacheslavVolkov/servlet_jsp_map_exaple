package epam;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for storing of google map locations (is the http session)
 */
public class Servlet extends HttpServlet {

    private final static String ATTRIBUTE = "locations";

    /**
     * POST Store location (latitude, longitude) to the session
     *
     * @param req HttpServletRequest
     * @param resp HttpServletResponse
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<String> locations = (List<String>) session.getAttribute(ATTRIBUTE);
        if (locations != null) {
            locations.add(req.getHeader("location"));
        } else {
            locations = new ArrayList<String>();
            locations.add(req.getHeader("location"));
            session.setAttribute(ATTRIBUTE, locations);
        }
    }

    /**
     * GET return all locations from the session
     *
     * @param req HttpServletRequest
     * @param resp HttpServletResponse
     */
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> locations = (List<String>) req.getSession().getAttribute(ATTRIBUTE);
        for (String location : locations) {
            resp.getWriter().write(location + ", ");
        }
    }
}