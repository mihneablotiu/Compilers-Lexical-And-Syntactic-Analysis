package cool.ast.feature;

import cool.ast.ASTVisitor;
import cool.ast.expression.Expression;
import cool.ast.expression.ObjectId;
import cool.ast.type.TypeId;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

public class Field extends Feature {
    private final ObjectId fieldId;
    private final TypeId typeId;
    private final Expression initialExpr;

    public Field(Token token, ParserRuleContext parserRuleContext,
                 ObjectId fieldId, TypeId typeId, Expression initialExpr) {
        super(token, parserRuleContext);
        this.fieldId = fieldId;
        this.typeId = typeId;
        this.initialExpr = initialExpr;
    }

    public ObjectId getFieldId() {
        return fieldId;
    }

    public TypeId getTypeId() {
        return typeId;
    }

    public Expression getInitialExpr() {
        return initialExpr;
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
