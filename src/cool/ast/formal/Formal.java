package cool.ast.formal;

import cool.ast.ASTNode;
import cool.ast.ASTVisitor;
import cool.ast.expression.ObjectId;
import cool.ast.type.TypeId;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

public class Formal extends ASTNode {
    private final ObjectId objectId;
    private final TypeId typeId;

    public Formal(Token token, ParserRuleContext parserRuleContext,
                  ObjectId objectId, TypeId typeId) {
        super(token, parserRuleContext);
        this.objectId = objectId;
        this.typeId = typeId;
    }

    public ObjectId getObjectId() {
        return objectId;
    }

    public TypeId getTypeId() {
        return typeId;
    }


    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
