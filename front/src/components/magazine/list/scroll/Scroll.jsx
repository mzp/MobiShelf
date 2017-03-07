/* eslint-disable react/no-set-state */
import React from "react";
import scrollTo from "scroll-to";
import cx from "classnames";
import NavButton from "./NavButton";
import b from "components/lib/b";

function floor (n, base) {
    return Math.floor(n / base) * base;
}

function ceil (n, base) {
    return Math.ceil(n / base) * base;
}

export default class extends React.Component {
    static displayName = "MagazineList.Scroll"
    static propTypes = {
        "children": React.PropTypes.arrayOf(React.PropTypes.element),
        "layout": React.PropTypes.func
    }

    static defaultProps = {"children": []}

    constructor (...args) {
        super(...args);

        this.state = {"scroll": 0};

        this.handleScroll = (e) => {
            this.setState({"scroll": e.target.scrollLeft});
        };
    }

    componentWillUnmount () {
        this.contents.removeEventListener("scroll", this.handleScroll);
        this.contents = null;
    }

    ref (contents) {
        if (this.contents) {
            return;
        }
        if (!contents) {
            return;
        }
        this.contents = contents;
        contents.addEventListener("scroll", this.handleScroll);
    }

    isPrev () {
        if (!this.contents) {
            return true;
        }
        const max = this.contents.scrollWidth - this.contents.offsetWidth;


        return this.state.scroll !== max;
    }

    onPrev () {
        scrollTo(this.contents, floor(this.x + this.unit, this.width()), 0);
    }

    isNext () {
        return this.state.scroll !== 0;
    }

    onNext () {
        scrollTo(this.contents, ceil(this.x - this.unit, this.width()), 0);
    }

    get x () {
        return this.contents.scrollLeft;
    }

    get unit () {
        return this.width() * 3;
    }

    render () {
        const {children, layout} = this.props;
        const scroll = b.with("scrollLayout");

        return (
            <div className={scroll()}>
                <NavButton
                    enable={this.isPrev()}
                    label="<"
                    layout={scroll("prev")}
                    onNav={::this.onPrev}
                />
                <NavButton
                    enable={this.isNext()}
                    label=">"
                    layout={scroll("next")}
                    onNav={::this.onNext}
                />
                <div
                    className={cx(scroll("contents"), layout())}
                    ref={::this.ref}
                >
                    <div
                        className={layout("panel")}
                        ref={(c) => {
                            this.width = () => c.offsetWidth;
                        }}
                    />
                    {children}
                    <div className={layout("panel")} />
                </div>
            </div>
        );
    }
}
