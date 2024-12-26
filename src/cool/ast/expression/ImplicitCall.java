package cool.ast.expression;

import cool.ast.ASTVisitor;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

public class ImplicitCall extends Expression {
    private final ObjectId methodId;
    private final ArrayList<Expression> params;

    public ImplicitCall(Token token, ParserRuleContext parserRuleContext,
                        ObjectId methodId, ArrayList<Expression> params) {
        super(token, parserRuleContext);
        this.methodId = methodId;
        this.params = params;
    }

    public ObjectId getMethodId() {
        return methodId;
    }

    public ArrayList<Expression> getParams() {
        return params;
    }


    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
