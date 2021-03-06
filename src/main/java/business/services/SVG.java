package business.services;

import static java.lang.Math.ceil;

public class SVG {
    StringBuilder svg = new StringBuilder();

    private int x;
    private int y;
    private String viewBox;
    private int width;
    private int height;

    private final String headerTemplate = "<svg height=\"%d%%\" " +
            "width=\"%d%%\" " +
            "viewBox=\"%s\" " +
            "x=\"%d\" " +
            "y=\"%d\" " +
            " preserveAspectRatio=\"xMinYMin\">";

    private final String rectTemplate = "<rect x=\"%d\" y=\"%d\" height=\"%d\" width=\"%d\" style=\"stroke:#000000; fill: #ffffff\"/>";
    private final String lineTemplate = "<line x1=\"%d\" y1=\"%d\" x2=\"%d\" y2=\"%d\" stroke=\"black\" style=\"stroke-dasharray: 4 4\"/>";
    private final String arrowTemplate = "<line x1=\"%d\" y1=\"%d\" x2=\"%d\" y2=\"%d\" style=\"stroke:#000000; fill: #ffffff;marker-start: url(#beginArrow); marker-end: url(#endArrow)\"/>";
    private final String textTemplate = "<text style=\"text-anchor: middle\" transform=\"translate(%d, %d) rotate(%d)\">%d %s</text>";

    private final String markerTemplate = "<defs>\n" +
            "        <marker\n" +
            "                id=\"beginArrow\"\n" +
            "                markerWidth=\"12\"\n" +
            "                markerHeight=\"12\"\n" +
            "                refX=\"0\"\n" +
            "                refY=\"6\"\n" +
            "                orient=\"auto\">\n" +
            "            <path d=\"M0,6 L12,0 L12,12 L0,6\" style=\"fill: #000000;\"/>\n" +
            "        </marker>\n" +
            "        <marker\n" +
            "                id=\"endArrow\"\n" +
            "                markerWidth=\"12\"\n" +
            "                markerHeight=\"12\"\n" +
            "                refX=\"12\"\n" +
            "                refY=\"6\"\n" +
            "                orient=\"auto\">\n" +
            "            <path d=\"M0,0 L12,6 L0,12 L0,0 \" style=\"fill: #000000;\"/>\n" +
            "        </marker>\n" +
            "    </defs>";

    public SVG(int x, int y, String viewBox, int width, int height) {
        this.x = x;
        this.y = y;
        this.viewBox = viewBox;
        this.width = width;
        this.height = height;
        svg.append(String.format(headerTemplate, height, width, viewBox, x, y)).append("\n");
    }

    public void SVGNest(int x, int y, String viewBox, int width, int height) {

        svg.append(String.format(headerTemplate, height, width, viewBox, x, y)).append("\n");
    }

    public void addRect(int x, int y, int height, int width) {
        svg.append(String.format(rectTemplate, x, y, height, width)).append("\n");
    }

    public void addLine(int x1, int y1, int x2, int y2) {
        svg.append(String.format(lineTemplate, x1, y1, x2, y2)).append("\n");
    }

    public void addArrow(int x1, int y1, int x2, int y2) {
        svg.append(String.format(arrowTemplate, x1, y1, x2, y2)).append("\n");
    }

    public void addMarker() {
        svg.append(String.format(markerTemplate)).append("\n");
    }

    public void addText(int x1, int y1, int x2, int y2, String s) {
        svg.append(String.format(textTemplate, x1, y1, x2, y2, s)).append("\n");
    }

    public void drawFrame(int length, int width) {
        addRect(0, 0, width, length);
    }

    public void drawFrameSideView(int y,int length, int width) {
        addRect(0, y, width, length);
    }

    public void drawRem(int x, int carportWidth, int carportLength) {
        addRect(x, 15, 4, carportLength);
        addRect(x, carportWidth - 15, 4, carportLength);
    }

    public void drawRemSideView(int x, int carportWidth, int carportLength) {
        addRect(x, 15, 10, carportLength);
        addRect(x+5, 25, 10, carportLength-10);
    }

    public void drawPost(int quantity, int length, int carportWidth, boolean hasShed) {
        int spaceBetweenPost;
        int offset = 100;

        if (hasShed) {
            spaceBetweenPost = (length - offset) / ((quantity / 2) - 1);
        } else {
            spaceBetweenPost = ((length - (offset+offset)) / ((quantity / 2) - 1));
        }

        for (int x = 0; x < quantity / 2; x++) {
            addRect((offset + (spaceBetweenPost * x)) - 20, 12, 10, 10);
            addRect((offset + (spaceBetweenPost * x)) - 20, carportWidth - 18, 10, 10);
        }
    }

    public void drawPostSideView(int quantity, int length, int carportWidth, boolean hasShed) {
        int spaceBetweenPost;
        int offset = 100;

        if (hasShed) {
            spaceBetweenPost = (length - offset) / ((quantity / 2) - 1);
        } else {
            spaceBetweenPost = ((length - (offset+offset)) / ((quantity / 2) - 1));
        }

        for (int x = 0; x < quantity / 2; x++) {
            addRect((offset + (spaceBetweenPost * x)) - 20, 15, 230, 10);
        }
    }


    public void drawMetalBand(int length, int width) {
        addLine(0, 15, length, width-15);
        addLine(0, width-15, length, 15);
    }

    public void drawRafter(int quantity, int length, int width) {
        int offset = (int) ceil((double) length / (double) (quantity - 1));

        for (int x = 0; x < quantity - 1; x++) {
            addRect(((offset * x)), 0, width, 4);
        }
        addRect(length, 0, width, 4);
    }

//    public void drawShed(int quantity, int length, int shedWidth) {
//        int distance = length / (quantity - 1);
//        int offset = 350;
//
//
//        for (int x = 0; x < quantity; x++) {
//            addRect(length, shedWidth - offset * x, 10, 10);
//            addRect(length - 3, shedWidth - offset * x, 10, 10);
//
//        }
//
//    }

    public void drawShedPosts(int quantity, int quantityLength, int quantityWidth, int carportLength, int length, int shedWidth) {
//        for (int i = 0; i < quantityLength; i++){
//            for (int j = 0; j < quantityWidth; j++) {
//                addRect((carportLength - length - 20) * i, (x+12) * j, 10,10);
//            }
//        }

        int offset = shedWidth / ((quantity / 2) - 1);
        for (int x = 0; x < quantity / 2; x++) {
            addRect(carportLength - length - 20, offset * x + 12, 10, 10);
            addRect(carportLength - 20, offset * x + 12, 10, 10);
        }
    }

    public void drawShedPostsSideView(int quantity, int carportLength, int length, int shedWidth) {
        int offset = shedWidth / ((quantity / 2) - 1);
        for (int x = 0; x < quantity / 4; x++) {
            addRect(carportLength - length - 20, offset * x + 15, 230, 10);
            addRect(carportLength - 20, offset * x + 15, 230, 10);
        }

    }

    public void drawShedWood(int shedLength, int carportLength, int shedWith) {
        addRect(carportLength - shedLength - 20, 15, shedWith, 10);
        addRect(carportLength - 20, 15, shedWith, 10);

    }
    public void drawShedWoodSide(int shedLength, int carportLength, int shedWidth) {
        addRect(carportLength - shedLength - 20, 12, 10, shedLength);
        addRect(carportLength - shedLength - 20, 12 + shedWidth, 10, shedLength);

    }

    public void drawShedCladding(int quantity, int length, int width, int carportLength) {
        quantity = quantity/4;
        int offset = (int) ceil((double) length / (double) (quantity - 1));


        for (int x = 0; x < quantity - 1; x++) {
            addRect((carportLength-10-(offset * x)), 25, 220, 4);
        }

    }


    public void addSVG(SVG innerSVG) {
        svg.append(innerSVG.toString());
    }

    @Override
    public String toString() {
        return svg.toString() + "</svg>";
    }
}
